//
//  NetworkService.swift
//  RoktDemo
//
//  Created by Danial on 7/15/21.
//

import Combine
import Alamofire

struct NetworkService {
    static func request<T: Decodable, E: Error>(
        url: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        decoder: JSONDecoder = JSONDecoder(),
        headers: HTTPHeaders? = getDefaultHeader()
    ) -> Future<T, E> {
        return Future({ promise in
            AF.request(
                url,
                method: method,
                parameters: parameters,
                headers: headers
            ).responseDecodable(decoder: decoder, completionHandler: { (response: DataResponse<T, AFError>) in
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    print("result \(value)")
                    promise(.success(value))
                case .failure(let error):
                    promise(.failure(
                        NSError(domain: error.destinationURL?.absoluteString ?? "", code: error.responseCode ?? 0, userInfo: ["error": error.localizedDescription]) as! E
                    )
                    )
                }
            })
        })
    }
    
    static func getDefaultHeader() -> HTTPHeaders {
        return HTTPHeaders([HTTPHeader(name: "Accept", value: "application/json"),
                            HTTPHeader(name: "Content-Type", value: "application/json")
        ])
    }
}
