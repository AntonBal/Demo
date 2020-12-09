//
//  ViewModel.swift
//  Demo
//
//  Created by Anton Bal’ on 02.07.2020.
//  Copyright © 2020 Anton Bal’. All rights reserved.
//

import UIKit

protocol ViewModelProtocol: UseCasesConsumer {
    var coordinator: Any { get set }
}

private enum ViewModelProtocolKeys {
    static var coordinator = "coordinator"
}

extension ViewModelProtocol {
    var coordinator: Any {
        get {
            if let coordinator: AnyObject = ObjcRuntime.getAssociatedObject(
                object: self,
                key: &ViewModelProtocolKeys.coordinator) {
                return coordinator
            } else { fatalError("useCases are required for \(Self.self)") }
        }
        
        set {
            ObjcRuntime.setAssociatedObject(object: self,
                                            value: newValue,
                                            key: &ViewModelProtocolKeys.coordinator,
                                            policy: .retain)
        }
    }
}

extension UIViewController {
    static var describing: String {
        return String(describing: `self`)
    }
    
    func setCoordinator<C: CoordinatorProtocol>(_ coordinator: C) {
        setAssociatedObject(value: coordinator,
                            key: ViewModelProtocolKeys.coordinator,
                            policy: .retainNonatomic)
    }
}
