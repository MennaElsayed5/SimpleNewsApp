//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Menna on 20/09/2022.
//
import RxSwift
import RxCocoa
import Foundation
protocol NewsProtocolViewModel{
    func getNewsFromApi(countryName:String,catgoryId:String)
    var  newsObservable: Observable<[Article]>{get set}
    func addnewsToCoreData(article:Articles,completion: @escaping (Bool)->Void) throws
    func checkNewsInCoreData(data: String,auther:String)
    func getAllnewsInCoreData(completion: @escaping (Bool)->Void) throws
    func removeNewsFromCoreDatat(title:String, completionHandler:@escaping (Bool) -> Void) throws
    func saveoCoreData(title: String,img:String,desc:String,source:String, data: String,auther:String,completion:@escaping (Bool) -> Void)throws
}
final class NewsViewModel:NewsProtocolViewModel{
    func saveoCoreData(title: String, img: String, desc: String, source: String, data: String,auther:String,completion:@escaping (Bool) -> Void) throws {
        do{
            try localDataSource?.saveoCoreData(title: title, img: img, desc: desc, source: source, data: data,auther:auther)
            completion(true)
            
        }catch let error {
            completion(false)
            throw error
        }
    }
    
    var localDataSource:LocalDataSourcable?
    var articleList:[Articles]?
    var isFav : Bool?

    func addnewsToCoreData(article:Articles,completion: @escaping (Bool) -> Void) throws {
        do{
            try  localDataSource?.saveArticleToCoreData(articles: article)
            completion(true)
        }
        catch let error{
            completion(false)
            throw error
        }
    }
    
    func checkNewsInCoreData(data: String,auther:String) {
        do{
            try isFav = localDataSource?.isFavouriteArticle(data: data,auther:auther)
        //    isFav = true
            print("isfavvvvv\(isFav)")
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
    
    var network = APIClint()
    var newsObservable: Observable<[Article]>
    private var allnewsSubject : PublishSubject = PublishSubject<[Article]>()
    
    init(appDelegate: AppDelegate){
        localDataSource = LocalDataSource(appDelegate: appDelegate)
        newsObservable = allnewsSubject.asObserver()
    }
    func getNewsFromApi(countryName: String, catgoryId: String) {
        network.getNews(countryName: countryName, catgoryId: catgoryId) { [weak self] result in
            switch result{
            case .success(let response):
                guard let newsData = response.articles else{return}
                self?.allnewsSubject.asObserver().onNext(newsData)
                print("vmNews\(newsData.count)")
            case .failure(let error):
                self?.allnewsSubject.asObserver().onError(error)
            }
        }

    }
//    func allNews(){
//        network.getall { [weak self] result in
//                        switch result{
//                        case .success(let response):
//                             let newsData = response.articles
//                            self?.allnewsSubject.asObserver().onNext(newsData)
//                            print("vmNews\(newsData.count)")
//                        case .failure(let error):
//                            self?.allnewsSubject.asObserver().onError(error)
//                        }
//                    }
//    }
}
