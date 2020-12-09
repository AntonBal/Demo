//
//  AppCoordinator.swift
//  Demo
//
//  Created by Anton Bal’ on 02.07.2020.
//  Copyright © 2020 Anton Bal’. All rights reserved.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {
    typealias RootController = UINavigationController
    
    let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
    let rootController: UINavigationController
    let useCases: UseCasesProvider
    
    init(useCases: UseCasesProvider) {
        self.useCases = useCases
        self.rootController = UINavigationController()
      
        start()
    }
    
    func start() {
        let vc: AllNewsViewController = makeController(viewModel: AllNewsViewModel()) { $0.delegate = self }
        rootController.setViewControllers([vc], animated: false)
        window.rootViewController = rootController
        window.makeKeyAndVisible()
    }
}

//MARK: - AllNewsViewControllerDelegate

extension AppCoordinator : AllNewsViewControllerDelegate {
    func allNewsViewController(_ vc: AllNewsViewController, didSelect news: News) {
        let vc: DetailedNewsViewController = makeController(viewModel: DetailedNewsViewModel(news: news))
        rootController.pushViewController(vc, animated: true)
    }
}
