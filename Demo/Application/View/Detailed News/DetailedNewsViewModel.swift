//
//  DetailedNewsViewModel.swift
//  Demo
//
//  Created by Anton Bal’ on 02.07.2020.
//  Copyright © 2020 Anton Bal’. All rights reserved.
//

import Foundation
import AVFoundation

final class DetailedNewsViewModel: ViewModelProtocol {
    typealias UseCases = HasNewsUseCase
    
    let news: News
    let title = "News"
    var name: String { news.title }
    
    var player: AVPlayer { AVPlayer(url: URL(string: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!) }
    
    init(news: News) {
        self.news = news
    }

}
