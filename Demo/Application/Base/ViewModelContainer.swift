//
//  ViewModelContainer.swift
//  Demo
//
//  Created by Anton Bal’ on 02.07.2020.
//  Copyright © 2020 Anton Bal’. All rights reserved.
//

import UIKit

// MARK: - ViewModelContainer
protocol ViewModelContainer: class {
    associatedtype ViewModel: ViewModelProtocol
    
    var viewModel: ViewModel { get set }
    func didSetViewModel(_ viewModel: ViewModel)
}

private enum ViewModelContainerKeys {
    static var viewModel = "viewModel"
    static var lifetimeToken = "lifetimeToken"
}

extension ViewModelContainer where Self: NSObject {
    
    var viewModel: ViewModel {
        get {
            return getAssociatedObject(key: &ViewModelContainerKeys.viewModel)!
        }
        set {
            let viewModel: ViewModel? = getAssociatedObject(key: &ViewModelContainerKeys.viewModel)
            assert(viewModel == nil, "\(type(of: self)) doesn't support reusable viewModel. Use ReusableViewModelContainer instead.")
            
            setAssociatedObject(value: newValue, key: &ViewModelContainerKeys.viewModel, policy: .retain)
            
            didSetViewModel(newValue)
        }
    }
}
