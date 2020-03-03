//
//  DataClass.swift
//  Test
//
//  Created by Apple on 28/02/20.
//  Copyright © 2020 Pratik Patil. All rights reserved.
//

import Foundation

struct DataClass : Codable {
    let format : String?
    let width : Int?
    let height : Int?
    let filename : String?
    let id : Int?
    let author : String?
    let author_url : String?
    let post_url : String?

    enum CodingKeys: String, CodingKey {

        case format = "format"
        case width = "width"
        case height = "height"
        case filename = "filename"
        case id = "id"
        case author = "author"
        case author_url = "author_url"
        case post_url = "post_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        format = try values.decodeIfPresent(String.self, forKey: .format)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        filename = try values.decodeIfPresent(String.self, forKey: .filename)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        author_url = try values.decodeIfPresent(String.self, forKey: .author_url)
        post_url = try values.decodeIfPresent(String.self, forKey: .post_url)
    }

}
