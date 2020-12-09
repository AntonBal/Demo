//
//  NewsAPI.swift
//  Demo
//
//  Created by Anton Bal’ on 02.07.2020.
//  Copyright © 2020 Anton Bal’. All rights reserved.
//

import Foundation
import Moya

enum NewsAPI: NetworkTarget {
    
    case all(params: NewsParams)
    
    var path: String { "trendingtopics" }
    
    var method: Moya.Method { .get }
    
    var headers: [String : String]? { [
        "x-rapidapi-host":  "bing-news-search1.p.rapidapi.com",
        "x-rapidapi-key": "f9fa749bb2msh57e1f7bc1e577c1p1c0658jsndf210f3758e7",
        "x-bingapis-sdk": "true",
        ] }
    
    var task: Task {
        switch self {
        case .all(let params):
            return .requestParameters(parameters: params.parameters, encoding: URLEncoding.default)
        }
    }
}
