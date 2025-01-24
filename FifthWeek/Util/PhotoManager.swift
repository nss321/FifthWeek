//
//  PhotoManager.swift
//  FifthWeek
//
//  Created by BAE on 1/21/25.
//

import Foundation
import Alamofire

// 연관값! Associated Value!
enum UnsplashRequest {
    case randomPhoto(count: Int = 1)
    case topic(id: String)
    case photo(query: String)
    
    var baseURL: String {
        return "https://api.unsplash.com/"
    }
    
    var endpoint: URL {
        switch self {
        case .randomPhoto(let count):
            return URL(string: self.baseURL + "photos/random?count=\(count)")!
        case .topic(let id):
            return URL(string: self.baseURL + "topics/\(id)")!
        case .photo(let query):
            return URL(string: self.baseURL + "photos/\(query)")!
            
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": "Client-ID \(APIKeys.photoSearchAPI)"]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        return ["page":"1", "color":"white","order_by":"relevant"]
    }
    
}

class PhotoManager {
    static let shared = PhotoManager()
    private init() { }
    
    func getRandomPhoto(api: UnsplashRequest,
                        completion: @escaping ([RandomPhoto]) -> (),
                        failHandler: @escaping () -> ()
    ) {
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: [RandomPhoto].self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    completion(value)
                case .failure(let error):
                    print(error)
                    failHandler()
                }
            }
    }
    
    func getRandomPhotoList(api: UnsplashRequest,
                        completion: @escaping (RandomPhoto) -> (),
                        failHandler: @escaping () -> ()
    ) {
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: RandomPhoto.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    completion(value)
                case .failure(let error):
                    print(error)
                    failHandler()
                }
            }
    }
    
    
    
    func callRequest(api: UnsplashRequest,
                   completion: @escaping (RandomPhoto) -> (),
                   failHandler: @escaping () -> ()
    ) {

        AF.request(api.endpoint, method: api.method, headers: api.header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: RandomPhoto.self) { response in
                print(api.endpoint)
                debugPrint(response)
                switch response.result {
                case .success(let value):
                    print(value)
                    completion(value)

                case .failure(let error):
                    print(error)
                    failHandler()
                }
            }
    }
    
    func getATopic(api: UnsplashRequest,
                   completion: @escaping (Topic) -> (),
                   failHandler: @escaping () -> ()
    ) {
        AF.request(api.endpoint, method: api.method, headers: api.header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: Topic.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    completion(value)
                    
                case .failure(let error):
                    print(error)
                    failHandler()
                    
                }
            }
    }
    
    func example<T: Decodable>(
        api: UnsplashRequest,
        successHandler: @escaping (T) -> Void,
        failHandler: @escaping () -> Void
    ) {
        AF.request(api.endpoint, method: api.method, headers: api.header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    successHandler(value)
                case .failure(let error):
                    print(error)
                    failHandler()
                }
            }
    }
    
    func example2<T: Decodable>(
        api: UnsplashRequest,
        type: T.Type, // 직접적으로 사용하지는 않지만, 타입을 일치시켜주기 위해 사용
        successHandler: @escaping (T) -> Void,
        failHandler: @escaping () -> Void
    ) {
        AF.request(api.endpoint, method: api.method, headers: api.header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    successHandler(value)
                case .failure(let error):
                    print(error)
                    failHandler()
                }
            }
    }
    
    func test(a: Int.Type) {
        
    }
    
}
