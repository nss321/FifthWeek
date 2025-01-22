//
//  NetworkManager.swift
//  FifthWeek
//
//  Created by BAE on 1/20/25.
//

import UIKit

class NetworkManager: AnyObject {
    static let shared = NetworkManager()
    
    static let url = URL(string: "https://picsum.photos/200/300")
    
    private init() { }
    
    func fetchImage(completion: @escaping (UIImage) -> Void) {
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: NetworkManager.url!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
            }
        }
        
    }
}


