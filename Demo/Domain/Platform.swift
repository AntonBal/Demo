//
//  Platform.swift
//  Demo
//
//  Created by Anton Bal’ on 02.07.2020.
//  Copyright © 2020 Anton Bal’. All rights reserved.
//

import Foundation


class Platform: UseCasesProvider {
    var news: NewsUseCase
    
    init(environment: Environment) {
        let network = Network(environment: environment)
        let context = ServiceContext(environment: environment, network: network)
        news = NewsService(context: context)
    }
}
