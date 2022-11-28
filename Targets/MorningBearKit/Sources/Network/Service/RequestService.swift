//
//  RequestService.swift
//  Naenio
//
//  Created by 이영빈 on 2022/08/17.
//
import RxSwift

class RequestService<Response: Decodable> {
    static func request(api: MBearAPI) -> Single<Response> {
        let sequence = api.request()
            .map { response -> Response in
                let data = response.data
                
//                print(String(data: data, encoding: .utf8) as Any)
                let decoded = try MBearAPI.jsonDecoder.decode(Response.self, from: data)
                return decoded
            }
        
        return sequence
    }
}
