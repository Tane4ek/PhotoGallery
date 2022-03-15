//
//  NetworkDataFeatcher.swift
//  PhotoGallery
//
//  Created by Tatiana Luzanova on 07.03.2022.
//

import UIKit
class NetworkDataFeatcher {
    var networkService = NetworkService()
    
    func fetchImages(page: Int, completion: @escaping (SearchResults?) -> ()) {
        networkService.request(page: page, completion: { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: SearchResults.self, from: data)

            completion(decode)
        })
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else {return nil}
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
    
    func getImage(from index: Int, url: String, completion:@escaping ((UIImage?) -> Void)) {
        guard let url = URL(string: url)
        else {
            print("Unable to create URL")
            completion(nil)
            return
        }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url, options: [])
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    completion(image)
                }
            }
            catch {
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
