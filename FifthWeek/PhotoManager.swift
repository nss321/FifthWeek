//
//  PhotoManager.swift
//  FifthWeek
//
//  Created by BAE on 1/21/25.
//

import Alamofire

class PhotoManager {
    static let shared = PhotoManager()
    private init() { }
    
    func getRandomPhoto() {
        let url = "https://api.unsplash.com/photos/random"
        
        let header: HTTPHeaders = [
            "Authorization": "Client-ID \(APIKeys.photoSearchAPI)"
        ]
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: RandomPhoto.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
