//
//  NetworkService.swift
//  PhotoGallery
//
//  Created by Tatiana Luzanova on 07.03.2022.
//

import UIKit

class NetworkService {
    
    func request(page: Int, completion: @escaping (Data?, Error?) -> Void) {
        
        let parameters = self.prepareParameters(page: page)
        let url = self.url(parameters: parameters)
        print("печать адреса", url)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func prepareHeader() -> [String: String]? {
        var headers: [String: String] = [:]
        headers["Authorization"] = "Client-ID QntSDW4enIpTPceHXev_8GMirxAutUstSR046Leos20"
        return headers
    }
    
    private func prepareParameters(page: Int) -> [String: String] {
        var parameters: [String: String] = [:]
        parameters["query"] = "flowers"
        parameters["page"] = String(page)
        parameters["per_page"] = String(30)
        return parameters
    }
    
    private func url(parameters: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = parameters.map{
            URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
