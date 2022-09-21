//
//  News.swift
//  NewsApp
//
//  Created by Menna on 20/09/2022.
//

import Foundation
struct NewsRequest: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Articles]?
}
struct Articles: Codable{
    let source: Sources?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}
struct Sources:Codable{
    let id: String?
    let name: String?

}
