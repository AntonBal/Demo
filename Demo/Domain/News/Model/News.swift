//
//  AllNews.swift
//  Demo
//
//  Created by Anton Bal’ on 02.07.2020.
//  Copyright © 2020 Anton Bal’. All rights reserved.
//

import Foundation

struct AllNews: Codable {
    let news: [News]
}

struct News: Codable {
    let title: String
    let url: URL
}
