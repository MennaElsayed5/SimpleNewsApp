//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Menna on 20/09/2022.
//
import RxSwift
import Foundation
import UIKit
protocol NewsProtocolViewModel{
    func getNewsFromApi(countryName:String,catgoryId:String)
    var  newsObservable: Observable<[Article]>{get set}
    func checkNewsInCoreData(data: String,auther:String)
    func getAllnewsInCoreData(completion: @escaping (Bool)->Void) throws
    func removeNewsFromCoreDatat(title:String, completionHandler:@escaping (Bool) -> Void) throws
    func saveoCoreData(title: String,img:String,desc:String,source:String, data: String,auther:String,completion:@escaping (Bool) -> Void)throws
    func searchArticales(text:String)
    func checkConnection()
    var  searchObservable: Observable<[Article]>{get set}
    var networkObservable:Observable<Bool> { get set }
    func openWebsite(url: String)
    var  articleList : [Articles]? {get set}
    var isFav:Bool? {get set}

}
final class NewsViewModel:NewsProtocolViewModel{
    var localDataSource:LocalDataSourcable?
    var network = APIClint()

    var articleList:[Articles]?
    var isFav : Bool?
    
    var searchObservable: Observable<[Article]>
    var newsObservable: Observable<[Article]>
    var networkObservable: Observable<Bool>

    private var allnewsSubject : PublishSubject = PublishSubject<[Article]>()
    private var searchSubject : PublishSubject = PublishSubject<[Article]>()
    var networkSubject = PublishSubject<Bool>()
    
    init(){
        localDataSource = LocalDataSource(appDelegate: ((UIApplication.shared.delegate as? AppDelegate)!))
        newsObservable = allnewsSubject.asObserver()
        searchObservable = searchSubject.asObserver()
        networkObservable = networkSubject.asObserver()
        
    }
    func getNewsFromApi(countryName: String, catgoryId: String) {
        network.getNews(countryName: countryName, catgoryId: catgoryId) { [weak self] result in
            switch result{
            case .success(let response):
                guard let newsData = response.articles else{return}
                self?.allnewsSubject.asObserver().onNext(newsData)
            case .failure(let error):
                self?.allnewsSubject.asObserver().onError(error)
            }
        }
    }
    
    func searchArticales(text: String) {
        network.searchArticales(text: text) { [weak self] result in
            switch result{
            case .success(let response):
                guard let newsData = response.articles else{return}
                self?.searchSubject.asObserver().onNext(newsData)
            case .failure(let error):
                self?.searchSubject.asObserver().onError(error)
            }
        }
    }
 
    func saveoCoreData(title: String, img: String, desc: String, source: String, data: String,auther:String,completion:@escaping (Bool) -> Void) throws {
        do{
            try localDataSource?.saveoCoreData(title: title, img: img, desc: desc, source: source, data: data,auther:auther)
            completion(true)
            
        }catch let error {
            completion(false)
            throw error
        }
    }
    
    func checkNewsInCoreData(data: String,auther:String) {
        do{
            try isFav = localDataSource?.isFavouriteArticle(data: data,auther:auther)
        }catch let error{
            print(error.localizedDescription)
            isFav=false
        }
    }
    
    func getAllnewsInCoreData(completion: @escaping (Bool) -> Void) throws {
        do{
            try  articleList =  localDataSource?.getArticleFromCoreData()
            completion(true)
        }catch let error{
            completion(false)
            throw error
        }
    }
    
    func removeNewsFromCoreDatat(title: String, completionHandler: @escaping (Bool) -> Void) throws {
        do{
            try localDataSource?.removeArticleFromCoreData(articleTitle: title)
            completionHandler(true)
        }catch let error{
            completionHandler(false)
            throw error
        }
    }
    func checkConnection(){
        HandelConnection.handelConnection.checkNetworkConnection { [weak self] isconn in
            if isconn{
                self?.networkSubject.asObserver().onNext(true)
            }else{
                self?.networkSubject.asObserver().onNext(false)
            }
        }
    }
    func openWebsite(url: String) {
        let application = UIApplication.shared
        if application.canOpenURL(URL(string: url)!){
            application.open(URL(string: url)!)
        }else{
            application.open(URL(string: "https://\(url)")!)

        }
    }
    
    

}
