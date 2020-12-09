//
//  Coordinator.swift
//  Demo
//
//  Created by Anton Bal’ on 02.07.2020.
//  Copyright © 2020 Anton Bal’. All rights reserved.
//

import UIKit

protocol CoordinatorProtocol: class {
    associatedtype RootController: UIViewController

    var rootController: RootController { get }
    var useCases: UseCasesProvider { get }
}

extension CoordinatorProtocol {
    func start() {}
    func stop() {}
}

extension CoordinatorProtocol {
    
    func makeController<T: UIViewController & Makeable & ViewModelContainer>(viewModel: T.ViewModel, _ builder: T.Builder) -> T
        
        where T.Value == T {
            
            guard let useCases = useCases as? T.ViewModel.UseCases else {
                fatalError("V.UseCases should be subset of Coordinator.UseCasesProvider")
            }
            
            let controller: T = T.make(builder)
            controller.viewModel = viewModel
            controller.viewModel.coordinator = self
            controller.viewModel.useCases = useCases
            return controller
    }
}
