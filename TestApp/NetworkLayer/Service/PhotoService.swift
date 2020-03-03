//
//  PhotoService.swift
//  TestApp
//
//  Created by Apple on 01/03/20.
//  Copyright © 2020 Pratik Patil. All rights reserved.
//

import Foundation

class PhotoService {
    
    func requestToFetchPhotosRecords(completionBlock: @escaping (_ photos: [DataClass]?, _ error: Error?) -> Void) {
        let service = "list"
        NetworkManager.shared.request(service: service, type: .GET) { (data, response, error) in
            if let data = data {
                autoParsing(myClass: [DataClass].self, data: data) { (records, parseError) in
                    completionBlock(records, parseError)
                }
            } else {
                 completionBlock(nil, error)
            }
        }
    }
}
