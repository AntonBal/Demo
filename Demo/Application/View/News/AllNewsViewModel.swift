//
//  NewsViewModel.swift
//  Demo
//
//  Created by Anton Bal’ on 02.07.2020.
//  Copyright © 2020 Anton Bal’. All rights reserved.
//

import Foundation
import RxSwift

final class AllNewsViewModel: ViewModelProtocol {
    typealias UseCases = HasNewsUseCase
    let disposeBag = DisposeBag()
    
    let title = "All news"
    
    private let all = BehaviorSubject<Array<News>?>(value: nil)
    
    var isEmpty: Observable<Bool> { all.map { $0?.isEmpty ?? false } }
    
    var news: [News] { (try? all.value()) ?? [] }
    
    private var offset = 0
    private static let limit = 10
    
    private(set) var isHasMore = true
    
    func useCaseDidAssigned() {
        loadMore()
    }
    
    func loadMore() {
        guard isHasMore else { return }
        useCases.news.all(params: NewsParams(count: AllNewsViewModel.limit, offset: offset)).subscribe(onSuccess: { [weak self] value in
            guard let self = self else { return }
            self.isHasMore = !value.news.isEmpty
            self.all.onNext(self.news + value.news)
            self.offset += AllNewsViewModel.limit
        }).disposed(by: disposeBag)
    }
}
