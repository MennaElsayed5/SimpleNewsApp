//
//  Articles.swift
//  NewsApp
//
//  Created by Menna on 20/09/2022.
//

import Foundation
struct Article: Codable {
        let source: Source?
        let author: String?
        let title: String?
        let description: String?
        let url: String?
        let urlToImage: String?
        let publishedAt: String?
        let content: String?
        
        struct Source: Codable {
            let id: String?
            let name: String?
        }
    }

