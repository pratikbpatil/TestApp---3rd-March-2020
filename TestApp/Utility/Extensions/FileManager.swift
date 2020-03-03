//
//  FileManager.swift
//  TestApp
//
//  Created by Apple on 01/03/20.
//  Copyright © 2020 Pratik Patil. All rights reserved.
//

import Foundation

public extension FileManager {
    func documentDirectoryUrl() -> URL? {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        } catch let exception {
            print("Get document directory exception: \(exception.localizedDescription)")
        }
        return nil
    }
    
    func createDirectory(url: URL) {
        do {
            if !FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: false, attributes: nil)
            }
        } catch let exception {
            print("exception while create directory: \(exception.localizedDescription)")
        }
    }
    
    func getFileWithShortPath(shortPath: String) -> URL? {
        let url = documentDirectoryUrl()?.appendingPathComponent(shortPath)
        if FileManager.default.fileExists(atPath: url?.path ?? "") {
            return url
        }
        
        return nil
    }
    
    func writeDataToFile(data: Data, fileURL: URL) {
        do {
            // Write to the file
            try data.write(to: fileURL)
        } catch let error as NSError {
            print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
        }
    }
}

