//
//  ServiceContext.swift
//  Demo
//
//  Created by Anton Bal’ on 02.07.2020.
//  Copyright © 2020 Anton Bal’. All rights reserved.
//

import Foundation

final class ServiceContext {
    
    let environment: Environment
    let network: Network
    
    init(environment: Environment, network: Network) {
        self.environment = environment
        self.network = network
    }
}
