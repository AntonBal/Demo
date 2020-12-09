//
//  AllNewsViewController.swift
//  Demo
//
//  Created by Anton Bal’ on 02.07.2020.
//  Copyright © 2020 Anton Bal’. All rights reserved.
//

import UIKit
import RxSwift
import AlamofireImage

extension AllNewsViewController: Makeable {
    static func make() -> AllNewsViewController {
        return AllNewsViewController()
    }
}

protocol AllNewsViewControllerDelegate : class {
    func allNewsViewController(_ vc: AllNewsViewController, didSelect news: News)
}

final class AllNewsViewController: UIViewController, ViewModelContainer {
    
    enum GUI {
        static let footerHeight: CGFloat = 50
    }
    
    typealias ViewModel = AllNewsViewModel
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        return tableView
    }()
    
    weak var delegate: AllNewsViewControllerDelegate?
    
    //MARK: - ViewModelContainer
    
    func didSetViewModel(_ viewModel: AllNewsViewModel) {
        tableView.backgroundColor = UIColor.lightGray
        title = viewModel.title
        viewModel.isEmpty.subscribeOn(MainScheduler.instance).subscribe(onNext: { [tableView] isEmpty in
            if !isEmpty {
                tableView.reloadData()
            }
        }).disposed(by: viewModel.disposeBag)
    }
    
}

//MARK: - UITableViewDelegate

extension AllNewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        viewModel.isHasMore ? indicator : nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        viewModel.isHasMore ? GUI.footerHeight : 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.allNewsViewController(self, didSelect: viewModel.news[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.news.count - 1 {
            indicator.startAnimating()
            viewModel.loadMore()
        } else {
            indicator.stopAnimating()
        }
    }
}


//MARK: - UITableViewDataSource

extension AllNewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "Cell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) ??  UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        let news = viewModel.news[indexPath.row]
        let link = news.url.relativeString
        
        cell.textLabel?.text = news.title
        
        let str = NSMutableAttributedString(string: link)
        str.addAttribute(.link, value: link, range: NSRange(location: 0, length: link.count))
        cell.detailTextLabel?.attributedText = str
        
        cell.imageView?.af.setImage(withURL: news.image.url, imageTransition: .crossDissolve(0.2), completion: {
            _ in
            cell.setNeedsLayout()
        })
        
        return cell
    }
}
