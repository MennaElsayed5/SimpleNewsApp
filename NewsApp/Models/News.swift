//
//  News.swift
//  NewsApp
//
//  Created by Menna on 20/09/2022.
//

import Foundation
struct News: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}
