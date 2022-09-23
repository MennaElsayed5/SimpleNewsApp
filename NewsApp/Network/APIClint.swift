//
//  APIClint.swift
//  NewsApp
//
//  Created by Menna on 20/09/2022.
//

import Foundation

class APIClint:NetworkServiceProtocol {
    func searchArticales(text: String, completion: @escaping (Result<News, ErrorType>) -> Void) {
        request(endpoint: .sharch(text: text), method: .GET, compeletion: completion)
    }
    
    func getNews(countryName: String, catgoryId: String, completion: @escaping (Result<News, ErrorType>) -> Void) {
        request(endpoint: .getNews(country: countryName, catgory: catgoryId), method: .GET, compeletion: completion)
    }
    
    private let BASE_URL = "https://newsapi.org/v2/"
    func request<T:Codable>(endpoint: EndPoints, method: Methods, compeletion: @escaping (Result<T, ErrorType>) -> Void) {
        let path = "\(BASE_URL)\(endpoint.path)"
        let urlString = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let urlString = urlString else {
            compeletion(.failure(.urlBadFormmated))
            return
        }
        guard let urlRequest = URL(string: urlString) else {
            compeletion(.failure(.InternalError))
            return
        }
        var  request = URLRequest(url: urlRequest)
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        request.httpMethod = "\(method)"
        callNetwork(urlRequest: request, completion: compeletion)
    }
    func callNetwork<T:Codable>(urlRequest:URLRequest, completion: @escaping (Result<T, ErrorType>) -> Void) {
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(.ServerError))
                return
            }
            guard let data = data else {
                completion(.failure(.ServerError))
                return
            }
            do{
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
                
            }    catch {
              //  print((response as! HTTPURLResponse).statusCode)
                    completion(.failure(.parsingError))
                }
        }.resume()
    }

}
