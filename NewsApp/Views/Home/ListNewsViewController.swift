//
//  ListNewsViewController.swift
//  NewsApp
//
//  Created by Menna on 20/09/2022.
//

import UIKit
import RxSwift
class ListNewsViewController: UIViewController {
    var countryName:String?
    var catgory:String?
    @IBOutlet weak var newsTb: UITableView!
     var newsViewModel: NewsProtocolViewModel?
     let disBag = DisposeBag()
     var arrayOfArticle: [Article] = []
     var articles : [Articles] = []
     var artile:Article?
     var isFav : Bool?
   private  var isConn:Bool = false
   private  let refreshController = UIRefreshControl()
    @IBOutlet weak var notConnectionView: UIView!
    let dispatchGroup = DispatchGroup()
    override func viewDidLoad() {
        super.viewDidLoad()
        newsViewModel = NewsViewModel()
        self.newsTb.delegate=self
        self.newsTb.dataSource=self
        let newsCell = UINib(nibName: "NewsTableViewCell", bundle: nil)
        newsTb.register(newsCell, forCellReuseIdentifier: "NewsTableViewCell")
        refreshController.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        newsTb.addSubview(refreshController)
    }
    override func viewWillAppear(_ animated: Bool) {
        checkNetwork()
        getArticlesFromCoreData()
    }
    func dataRequest(){
        dispatchGroup.enter()
        Firstfetch()
        dispatchGroup.leave()
        dispatchGroup.enter()
        secFetch()
        dispatchGroup.leave()
        dispatchGroup.enter()
        thirdFetch()
        dispatchGroup.leave()
        dispatchGroup.notify(queue: .main) {
            self.refreshController.endRefreshing()
        }
    }
    func checkNetwork() {
        newsViewModel?.checkConnection()
        newsViewModel?.networkObservable.subscribe {[weak self] isConn in
            self?.isConn = isConn
            if isConn == false{
                self?.notConnectionView.isHidden = false
            }else{
                self?.notConnectionView.isHidden = true
                self?.dataRequest()
            }
        } onError: { error in
            print("connection error network")
        }.disposed(by: disBag)

    }
    @objc func pullToRefresh(){
        refreshController.beginRefreshing()
        checkNetwork()
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            if self.refreshController.isRefreshing{
                self.refreshController.endRefreshing()
            }
        }
        
    }

}
extension ListNewsViewController{
    func Firstfetch(){
        newsViewModel?.getNewsFromApi(countryName:Utilities.utilities.getUserCountry(), catgoryId: Utilities.utilities.getArrCotgory()[0] as! String )
        newsViewModel?.newsObservable.subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { news in
                self.arrayOfArticle = news
                self.newsTb.reloadData()
            } onError: { error in
                print(error)
            } onCompleted: {
                self.dispatchGroup.leave()
            }.disposed(by: disBag)
    }
    func secFetch() {
        newsViewModel?.getNewsFromApi(countryName:Utilities.utilities.getUserCountry(), catgoryId: Utilities.utilities.getArrCotgory()[1] as! String )
        newsViewModel?.newsObservable.subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { news in
                DispatchQueue.main.asyncAfter(deadline:.now()+2.0){
                self.arrayOfArticle.append(contentsOf: news)
                    self.newsTb.reloadData()
                }
            } onError: { error in
                print(error)
            }onCompleted: {
                self.dispatchGroup.leave()
            }
            .disposed(by: disBag)
    }
    func thirdFetch(){
        newsViewModel?.getNewsFromApi(countryName:Utilities.utilities.getUserCountry(), catgoryId: Utilities.utilities.getArrCotgory()[2] as! String )
        newsViewModel?.newsObservable.subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { news in
                DispatchQueue.main.asyncAfter(deadline:.now()+4.0){
                self.arrayOfArticle.append(contentsOf: news)
                self.newsTb.reloadData()
                }
            } onError: { error in
                print(error)
            } onCompleted: {
                self.dispatchGroup.leave()
            }
            .disposed(by: disBag)
    }
}
