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
    var  newsObservable: Observable<[Articles]>{get set}
}
final class NewsViewModel:NewsProtocolViewModel{
    var network = APIClint()
    var newsObservable: Observable<[Articles]>
    private var allnewsSubject : PublishSubject = PublishSubject<[Articles]>()
    
    init(appDelegate :AppDelegate){
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
