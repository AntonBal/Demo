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
import Alamofire

struct NewsParams {
    let count: Int
    let offset: Int
    
    var parameters: [String: Any] {
        return ["textFormat": "Raw", "safeSearch": "Off", "count": "\(count)", "offset": "\(offset)"]
    }
}

class NewsService: NewsUseCase {
    let context: ServiceContext
    
    init(context: ServiceContext) {
        self.context = context
    }
    
    //MARK: - NewsUseCase
    
    func all(params: NewsParams) -> Single<AllNews> {
        context.network.request(NewsAPI.all(params: params)).map(AllNews.self)
    }
}
