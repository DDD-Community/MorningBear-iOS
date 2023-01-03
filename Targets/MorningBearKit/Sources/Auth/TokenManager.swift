//
//  TokenManager.swift
//  MorningBearKit
//
//  Created by 이건우 on 2023/01/02.
//  Copyright © 2023 com.dache. All rights reserved.
//

import MorningBearNetwork
import MorningBearAPI

public final class TokenManager {
    
    public enum AuthState: String {
        case kakao = "kakao"
        case apple = "apple"
    }
    
    public func encodeToken(state: AuthState, token: String) {
        Network.shared.apollo
            .fetch(query: EncodeQuery(state: GraphQLNullable(stringLiteral: state.rawValue), token: GraphQLNullable(stringLiteral: token))) { result in
            switch result {
            case .success(let graphQLResult):
                guard let encodedToken = graphQLResult.data?.encode else { return }
                
                // FIXME: RxApollo 적용 후 encodedToken을 LocalStorageManager를 통해 저장
                // 혹은 리턴 후 Apple/Kakao 로그인 매니저에서 따로 처리
                print("encodedToken is", encodedToken)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
