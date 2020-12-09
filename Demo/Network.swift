//
//  Network.swift
//  Demo
//
//  Created by Anton Bal’ on 02.07.2020.
//  Copyright © 2020 Anton Bal’. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Alamofire

protocol NetworkTarget {
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: Moya.Method { get }
    
    /// The type of HTTP task to be performed.
    var task: Task { get }
    
    /// Provides stub data for use in testing.
    var sampleData: Data { get }
    
    /// The headers to be used in the request.
    var headers: [String : String]? { get }
}

extension NetworkTarget {
    var sampleData: Data { Data() }
    var headers: [String : String]? { nil }
}

final class Network {
    
    let environment: Environment
    private let provider = MoyaProvider<EnvironmentTarget>()
    
    init(environment: Environment) {
        self.environment = environment
    }
    
    func request<Target: NetworkTarget>(_ target: Target) -> Single<Response> {
        return provider.rx.request(EnvironmentTarget(target: target, environment: environment))
    }
}

fileprivate struct EnvironmentTarget: TargetType {
    let target: NetworkTarget
    let environment: Environment
    
    var method: Moya.Method { target.method }
    var sampleData: Data { target.sampleData }
    var task: Task { target.task }
    var path: String { target.path }
    var baseURL: URL { URL(fileURLWithPath: environment.baseURLPath) }
    var headers: [String : String]? { target.headers }
}
