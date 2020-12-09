//
//  Makabel.swift
//  Demo
//
//  Created by Anton Bal’ on 02.07.2020.
//  Copyright © 2020 Anton Bal’. All rights reserved.
//

import Foundation

protocol Makeable {
    associatedtype Value = Self
    typealias Builder = (inout Value) -> Void
    static func make() -> Value
}

extension Makeable {
    static func make(_ builder: Builder) -> Value {
        var product = make()
        builder(&product)
        return product
    }
}
