//
//  Network.swift
//  MorningBearKit
//
//  Created by Young Bin on 2022/11/29.
//  Copyright © 2022 com.dache. All rights reserved.
//

import Foundation
import Apollo

class Network {
  static let shared = Network()

  private(set) lazy var apollo = ApolloClient(url: URL(string: "https://swapi-graphql.netlify.app/.netlify/functions/index")!)
}
