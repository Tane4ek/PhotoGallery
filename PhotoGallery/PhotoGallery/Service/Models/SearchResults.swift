//
//  SearchResults.swift
//  PhotoGallery
//
//  Created by Tatiana Luzanova on 08.03.2022.
//

import Foundation

struct SearchResults: Decodable {
    let total: Int
    let totalPages: Int
    let results: [UnsplashPhoto]
    
    enum CodingKeys: String, CodingKey {
        case total, results
        case totalPages = "total_pages"
    }
}

struct UnsplashPhoto: Decodable {
    let width: Int
    let height: Int
    let urls: [URLKing.RawValue: String]
    let createdAt: String
    
    enum URLKing: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
    
    enum CodingKeys: String, CodingKey {
        case width, height, urls
        case createdAt = "created_at"
    }
    
}

