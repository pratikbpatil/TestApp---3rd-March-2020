//
//  NetworkManager.swift
//  TestApp
//
//  Created by Apple on 01/03/20.
//  Copyright © 2020 Pratik Patil. All rights reserved.
//

import Foundation

let BASEURL = "https://picsum.photos/"

enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
    case UPDATE
}

class NetworkManager: NSObject {
    static let shared = NetworkManager()
    
    private override init() {
        super.init()
    }
    
    func request(service: String, type: Method, completionBlock: @escaping (_ response: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        
        let serviceString = BASEURL + service
        
        if let url = URL(string: serviceString) {
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration)
            
            var request = URLRequest(url: url)
            request.httpMethod = type.rawValue
            
            //data task
            let task = session.dataTask(with: request) { data, response, error in
                completionBlock(data, response, error)
            }
            task.resume()
        } else {
            completionBlock(nil, nil, nil)
        }
    }
}


func autoParsing<T: Decodable>(myClass: T.Type, data: Data, handler: @escaping (_ endResult: T?, _ error: Error?) -> Void) {
    do {
        let endResult = try JSONDecoder().decode(myClass, from: data)
        handler(endResult, nil)
    } catch let error {
        handler(nil, error)
    }
}
