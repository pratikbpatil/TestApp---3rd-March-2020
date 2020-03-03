//
//  ViewController.swift
//  Test
//
//  Created by Apple on 28/02/20.
//  Copyright © 2020 Pratik Patil. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    @IBOutlet var collectionViewOutlet: UICollectionView!
    var photos: [DataClass]? = nil
    
    var photoService: PhotoService? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialisePhotoService()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.fetchAllPhotosRecords()
    }
    
    private func initialisePhotoService() {
        if photoService == nil {
            photoService = PhotoService()
        }
    }
    
    private func configureCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: Screen.width/2, height: Screen.width/2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionViewOutlet.collectionViewLayout = layout
    }
    
    private func fetchAllPhotosRecords() {
        photoService?.requestToFetchPhotosRecords(completionBlock: { [weak self] (records, error) in
            if let error = error {
                print("Error to fetch photos records: \(error.localizedDescription)")
            } else {
                self?.photos = records
                DispatchQueue.main.async {
                    self?.collectionViewOutlet.reloadData()
                }
            }
        })
    }
}

extension PhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionViewOutlet.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell {
            
            if let photo = photos?[indexPath.row] {
                cell.lbl.text = photo.author
                let imageString = BASEURL + "300/300?image=\(photo.id ?? 0)"
                cell.imgViewOutlet.image = nil
                if let imageUrl = URL(string: imageString) {
                    cell.imgViewOutlet.load(url: imageUrl)
                }
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
}
