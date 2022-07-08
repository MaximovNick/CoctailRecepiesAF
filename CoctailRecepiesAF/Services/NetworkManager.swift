//
//  NetworkManager.swift
//  CoctailRecepiesAF
//
//  Created by Nikolai Maksimov on 06.07.2022.
//

import Foundation
import Alamofire

enum Link: String {
    case margaritasUrl = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    
        func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
            guard let url = URL(string: url ?? "") else {
                completion(.failure(.invalidURL))
                return
            }
            DispatchQueue.global().async {
                guard let imageData = try? Data(contentsOf: url) else {
                    completion(.failure(.noData))
                    return
                }
                DispatchQueue.main.async {
                    completion(.success(imageData))
                }
            }
        }
    
    
    func fetchDataWithAlamofire(_ url: String, completion: @escaping(Result<[Margarita], NetworkError>) -> Void) {
    
        AF.request(Link.margaritasUrl.rawValue)
            .validate()
            .responseJSON { dataRespons in
                switch dataRespons.result {
                case .success(let value):
                    let margaritas = Margarita.getDrinks(from: value)
                    completion(.success(margaritas))
                    
                case .failure(_):
                    completion(.failure(.decodingError))
                }
            }
    
    }
}
