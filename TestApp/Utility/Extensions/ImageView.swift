//
//  ImageView.swift
//  TestApp
//
//  Created by Apple on 01/03/20.
//  Copyright © 2020 Pratik Patil. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let storeImage = self?.getStoreFile(url: url) {
                DispatchQueue.main.async {
                    self?.image = storeImage
                }
            } else {
                if let data = try? Data(contentsOf: url) {
                    self?.storeImage(url: url, data: data)
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
    
    private func getLocalFilePath(url: URL) -> URL? {
        let fileName = "\(url)".MD5() ?? "image"
        let shortPath = "Images/\(String(describing: fileName))"
        guard let imageUrl = FileManager.default.documentDirectoryUrl()?.appendingPathComponent(shortPath) else { return nil }
        return imageUrl
    }
    
    private func getStoreFile(url: URL) -> UIImage? {
        let imageUrl = getLocalFilePath(url: url)
        let image = UIImage(contentsOfFile: imageUrl?.path ?? "")
        
        return image
    }
    
    private func storeImage(url: URL, data: Data) {
        if let imageUrl = getLocalFilePath(url: url) {
            FileManager.default.writeDataToFile(data: data, fileURL: imageUrl)
        }
    }
}


