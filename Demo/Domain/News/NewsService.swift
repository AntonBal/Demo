//
//  NewsService.swift
//  Demo
//
//  Created by Anton Bal’ on 02.07.2020.
//  Copyright © 2020 Anton Bal’. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class NewsService: NewsUseCase {
    let context: ServiceContext
    
    init(context: ServiceContext) {
        self.context = context
    }
    
    //MARK: - NewsUseCase
    
    func all() -> Single<AllNews> {
        return context.network.request(NewsAPI.all).map(AllNews.self)
    }
}

enum NewsAPI: NetworkTarget {
    
    case all
    
    
    var path: String { "" }
    
    var method: Moya.Method { .get }
    
    var sampleData: Data { Data() }
    
    var task: Task { .requestPlain }
}


struct AllNews: Codable {
    let news: [News]
}

struct News: Codable {
    let title: String
    let url: URL
}
