//
//  AllNews.swift
//  Demo
//
//  Created by Anton Bal’ on 02.07.2020.
//  Copyright © 2020 Anton Bal’. All rights reserved.
//

import Foundation

struct AllNews: Codable {
    enum CodingKeys: String, CodingKey {
        case news = "value"
    }
    
    let news: [News]
}

struct News: Codable {
    let title: String
    let url: URL
    let image: NewsImage
    
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case url = "webSearchUrl"
        case image
    }
}

struct NewsImage: Codable {
    let url: URL
}
