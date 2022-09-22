//
//  NetworkServiceProtocol.swift
//  NewsApp
//
//  Created by Menna on 20/09/2022.
//

import Foundation
protocol NetworkServiceProtocol{
    func getNews(countryName:String,catgoryId:String,completion:@escaping(Result<News,ErrorType>)->Void)
//    func getall(completion:@escaping(Result<News,ErrorType>)->Void)
    func searchArticales(text:String,completion:@escaping(Result<News,ErrorType>)->Void)
    
}
