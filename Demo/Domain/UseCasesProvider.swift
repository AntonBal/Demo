//
//  UseCasesProvider.swift
//  Demo
//
//  Created by Anton Bal’ on 02.07.2020.
//  Copyright © 2020 Anton Bal’. All rights reserved.
//

import Foundation

internal protocol HasNewsUseCase {
    var news: NewsUseCase { get }
}

typealias UseCases = HasNewsUseCase

protocol UseCasesProvider: UseCases { }
