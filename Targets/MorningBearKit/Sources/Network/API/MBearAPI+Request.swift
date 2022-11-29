//
//  NaenioAPI+Request.swift
//  Naenio
//
//  Created by 이영빈 on 2022/07/18.
//
import Moya
import RxMoya
import RxSwift
import Foundation

extension MBearAPI {
    static let moyaProvider = MBearAPI.defaultProvider
    
    static var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        return decoder
    }
    
    func request(
        provider: MoyaProvider<MBearAPI> = MBearAPI.moyaProvider,
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
    ) -> Single<Response> {
        let endpoint = self
        let requestString = "\(endpoint.method) \(endpoint.baseURL) \(endpoint.path)"
        
        print("endpoint: \(endpoint)")
        
        let mappedRequest = provider.rx.request(endpoint)
            .filterSuccessfulStatusCodes() // Throws error if code's not in 200-299
            .catch(self.handleInternetConnection)
            .catch(self.handleTimeOut)
            .catch(self.handleREST) // Handle rest of the errors
            .do(
                onSuccess: { response in
                    let requestContent = "🛰 SUCCESS: \(requestString) (\(response.statusCode))"
                    print(requestContent, file, function, line)
                },
                onError: { rawError in
                    print("🛰 FAILURE: \(requestString). Details at below ⬇️")
                    self.errorHandler(rawError)
                },
                onSubscribe: {
                    let message = "REQUEST: \(requestString)"
                    print(message, file, function, line)
                }
            )
                
            return mappedRequest
    }
    
    private func errorHandler(_ error: Error) {
        switch error {
        case MBearError.requestTimeout:
            print("TODO: alert MyAPIError.requestTimeout")
        case MBearError.internetConnection:
            print("TODO: alert MyAPIError.internetConnection")
        case let MBearError.restError(error, _, _):
            guard let response = (error as? MoyaError)?.response else {
                break
            }
            
            print("▶️ REST error: \(error) / content: \(String(describing: String(data: response.data, encoding: .utf8)))")
            
            if let jsonObject = try? response.mapJSON(failsOnEmptyData: false) {
                let errorDictionary = jsonObject as? [String: Any]
                
                guard let key = errorDictionary?.first?.key else { return }
                
                let message: String
                if let description = errorDictionary?[key] as? String {
                    message = "▶️ ERROR: (\(response.statusCode) \(key): \(description))"
                } else if let description = (errorDictionary?[key] as? [String]) {
                    message = "▶️ ERROR: (\(response.statusCode) \(key): \(description))"
                } else if let rawString = String(data: response.data, encoding: .utf8) {
                    message = "▶️ ERROR: (\(response.statusCode)) \(rawString))"
                } else {
                    message = "▶️ ERROR: Status code (\(response.statusCode))"
                }
                print(message)
            }
        default:
            print("▶️ Unknown error")
        }
    }
}
