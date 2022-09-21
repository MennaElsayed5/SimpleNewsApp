//
//  EndPoints.swift
//  NewsApp
//
//  Created by Menna on 20/09/2022.
//

import Foundation
private let KEY = "17cac229363b4302bf0a6fb608994a89"
enum EndPoints {
    case getNews(country:String,catgory:String)
    var path:String{
        switch self {
        case .getNews(country: let counryName, catgory: let catgoryId):
            return "country=\(counryName)&sortBy=publishedAt&category=\(catgoryId)&pageSize=100&apiKey=\(KEY)"
        }
}
}
