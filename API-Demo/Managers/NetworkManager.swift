//
//  NetworkManager.swift
//  API-Demo
//
//  Created by Daniel Hilton on 25/06/2020.
//  Copyright © 2020 Daniel Hilton. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    
    
    func downloadData<T:Codable> (url: String, completion: @escaping (Result<[T],CustomError>) -> ()) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print(error)
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let downloadedData = try decoder.decode([T].self, from: data)
                
                completion(.success(downloadedData))
                
            }
            catch {
                completion(.failure(.invalidData))
            }
            
        }.resume()
        
    }
    
    
    func downloadImage(fromURL urlString: String, completion: @escaping (UIImage?) -> ()) {
        let cacheKey = NSString(string: urlString)
        
        // if image is already stored in cache, use from there instead re-downloading
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard
                let self = self,
                    error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completion(nil)
                    return
            }
            self.cache.setObject(image, forKey: cacheKey) // save image to cache
            completion(image)
        }
        .resume()
    }
}
