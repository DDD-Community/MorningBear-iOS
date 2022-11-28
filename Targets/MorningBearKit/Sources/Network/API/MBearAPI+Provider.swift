//
//  AuthorizationAPI+Request.swift
//  Naenio
//
//  Created by 이영빈 on 2022/07/17.
//

import Moya
import RxSwift
import Alamofire
import Foundation

extension MBearAPI {
    static var defaultProvider: MoyaProvider<MBearAPI> {
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let networkLogger = NetworkLoggerPlugin(configuration: loggerConfig)
        
        let plugins = Plugins(plugins: [ networkLogger ])
        let session = DefaultSession.sharedSession
        
        let provider = MoyaProvider<MBearAPI>(
            endpointClosure: { target in
                MoyaProvider.defaultEndpointMapping(for: target)
            },
            session: session,
            plugins: plugins()
        )
        
        return provider
    }
}

fileprivate struct Plugins {
    var plugins: [PluginType]

    func callAsFunction() -> [PluginType] { self.plugins }

    init(plugins: [PluginType] = []) {
        self.plugins = plugins
    }
}
