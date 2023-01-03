//
//  Network.swift
//  MorningBearKit
//
//  Created by Young Bin on 2022/11/29.
//  Copyright © 2022 com.dache. All rights reserved.
//

import Foundation
import Apollo

public class Network {
    public static let shared = Network()
    
    public private(set) lazy var apolloTest = ApolloClient(url: URL(string: "https://swapi-graphql.netlify.app/.netlify/functions/index")!)
    
    public private(set) lazy var apollo = ApolloClient(url: URL(string: "http://138.2.126.76:8080/graphql")!)
}

