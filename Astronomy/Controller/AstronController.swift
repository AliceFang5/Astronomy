//
//  AstronController.swift
//  Astronomy
//
//  Created by 方芸萱 on 2021/6/18.
//

import UIKit

enum NetworkError: Error {
    case invalidUrl
    case requestFailed(Error)
    case invalidData
    case invalidResponse
    case decodingError(Error)
}

class AstronController{
    static let shared = AstronController()
    let astronURL = "https://raw.githubusercontent.com/cmmobile/NasaDataSet/main/apod.json"
    let imageCache = NSCache<NSURL, UIImage>()
    
    func fetchAstronData(completion: @escaping (Result<[AstronItem], NetworkError>) -> Void){
        guard let url = URL(string: astronURL) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                completion(.failure(.requestFailed(error)))
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else{
                completion(.failure(.invalidData))
                return
            }
            
            do{
                let jsonDecoder = JSONDecoder()
                let astronitems = try jsonDecoder.decode([AstronItem].self, from: data)
                completion(.success(astronitems))
            }catch{
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }
    
    func fetchImage(withURL urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void){
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        if let image = imageCache.object(forKey: url as NSURL){
            completion(.success(image))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error{
                completion(.failure(.requestFailed(error)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data, let image = UIImage(data: data) else{
                completion(.failure(.invalidData))
                return
            }
            completion(.success(image))
        }
        task.resume()
    }
}
