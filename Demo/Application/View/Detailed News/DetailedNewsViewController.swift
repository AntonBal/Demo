//
//  DetailedNewsViewController.swift
//  Demo
//
//  Created by Anton Bal’ on 02.07.2020.
//  Copyright © 2020 Anton Bal’. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

extension DetailedNewsViewController: Makeable {
    static func make() -> DetailedNewsViewController {
        let storyboard = UIStoryboard(name: "DetailedNewsStoryboard", bundle: nil)
        return storyboard.instantiateInitialViewController() as! DetailedNewsViewController
    }
}

class DetailedNewsViewController: UIViewController, ViewModelContainer{
    
    typealias ViewModel = DetailedNewsViewModel
    
    @IBOutlet private weak var playerViewContainer: UIView!
    @IBOutlet private weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = viewModel.name
        
        if let childVC = children.first as? AVPlayerViewController {
            childVC.player = viewModel.player
        }
    }
    
    func didSetViewModel(_ viewModel: DetailedNewsViewModel) {
        title = viewModel.title
    }
}
