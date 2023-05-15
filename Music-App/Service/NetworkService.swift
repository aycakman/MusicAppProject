//
//  NetworkService.swift
//  Music-App
//
//  Created by Ayca Akman on 12.05.2023.
//

import Foundation
import Alamofire

class NetworkService {
    func downloadData<T: Codable>(url: URL, completion: @escaping (T?) -> ()) {
        AF.request(url, method: .get).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                //print(data)
                completion(data)
            case .failure(let error):
                print("Error decoding data: \(error)")
                completion(nil)
            }
        }
    }
}


