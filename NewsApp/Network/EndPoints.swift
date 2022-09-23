//
//  EndPoints.swift
//  NewsApp
//
//  Created by Menna on 20/09/2022.
//

import Foundation
private let KEY = "cfb6154624504c3a9e93bc4ab969e941"
enum EndPoints {
    case getNews(country:String,catgory:String)
    case sharch(text:String)
    var path:String{
        switch self {
        case .getNews(country: let counryName, catgory: let catgoryId):
            return "top-headlines?country=\(counryName)&sortBy=publishedAt&category=\(catgoryId)&pageSize=100&apiKey=\(KEY)"
        case .sharch(text: let text):
            return "everything?q=\(text)&apiKey=\(KEY)"
        }
    }
}
