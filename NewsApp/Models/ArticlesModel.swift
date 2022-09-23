//
//  ArticlesModel.swift
//  NewsApp
//
//  Created by Menna on 21/09/2022.
//

import Foundation
struct News: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case totalResults = "totalResults"
        case articles = "articles"
    }
}
struct Article: Codable {
        let source: Source?
        let author: String?
        let title: String?
        let description: String?
        let url: String?
        let urlToImage: String?
        let publishedAt: String?
        let content: String?
    enum CodingKeys: String, CodingKey {
        case source = "source"
        case author = "author"
        case title = "title"
        case description = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
        case content = "content"
    }
    }

struct Source: Codable {
    let id: String?
    let name: String?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
