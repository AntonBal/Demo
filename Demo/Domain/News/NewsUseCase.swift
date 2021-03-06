//
//  NewsUsecase.swift
//  Demo
//
//  Created by Anton Bal’ on 02.07.2020.
//  Copyright © 2020 Anton Bal’. All rights reserved.
//

import Foundation
import RxSwift

protocol NewsUseCase {
    func all(params: NewsParams) -> Single<AllNews>
}
