//
//  KakaoAPIService.swift
//  Brandi
//
//  Created by 박연배 on 2022/03/27.
//

import Foundation

import Alamofire
import RxSwift

final class KakaoAPIService {
    
    enum APIError: String, Error {
        case badRequest
        case unAuthorized
        case forbidden
        case tooManyRequest
        case internalServerError
        case badGateway
        case serviceUnavailable
        case networkConnection
        case unknownError
        case emptyData = "검색 결과가 없습니다."
    }
    
    static let shared = KakaoAPIService()
    
    func apiErrorHandler(status: Int) -> APIError? {
        switch status {
        case 200:
            return nil
        case 400:
            return .badRequest
        case 401:
            return .unAuthorized
        case 403:
            return .forbidden
        case 429:
            return .tooManyRequest
        case 500:
            return .internalServerError
        case 502:
            return .badGateway
        case 503:
            return .serviceUnavailable
        default:
            return .unknownError
        }
    }
    
    func fetchSearchResponse(query: String, page: Int = 1, size: Int = 30) -> Single<Result<SearchData, APIError>> {
        return Single.create { single in
            if !(Connectivity.isConnectedToInternet) {
                single(.failure(APIError.networkConnection))
            }
            
            let params: [String:String] = [
                "query":query,
                "page":"\(page)",
                "size":"\(size)"
            ]
            
            let headers: HTTPHeaders = [
                Constants.Network.header:APIKey.key
            ]
            
            AF.request(Constants.Network.url,
                       method: .get,
                       parameters: params,
                       headers: headers)
                .validate().responseDecodable(of: SearchData.self) { [weak self]response in
                    if let error = self?.apiErrorHandler(status: response.response?.statusCode ?? 0) {
                        single(.failure(error))
                    }
                    single(.success(.success(response.value!)))
                }
            return Disposables.create()
        }
    }
    
    private init() {
        
    }
}
