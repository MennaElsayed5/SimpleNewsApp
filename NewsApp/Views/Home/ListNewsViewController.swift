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
     var newsViewModel: NewsViewModel?
     let disBag = DisposeBag()
     var arrayOfArticle: [Article] = []
     var articles : [Articles] = []
     var artile:Article?
     var isFav : Bool?
   private  var isConn:Bool = false
   private  let refreshController = UIRefreshControl()
    @IBOutlet weak var notConnectionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsViewModel = NewsViewModel(appDelegate: ((UIApplication.shared.delegate as? AppDelegate)!))
        self.newsTb.delegate=self
        self.newsTb.dataSource=self
        let newsCell = UINib(nibName: "NewsTableViewCell", bundle: nil)
        newsTb.register(newsCell, forCellReuseIdentifier: "NewsTableViewCell")
        refreshController.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        newsTb.addSubview(refreshController)
       // dataRequest()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        checkNetwork()
        getArticlesFromCoreData()

    }
    func dataRequest(){
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()   // <<---
        func firstFetchData(){
            newsViewModel?.getNewsFromApi(countryName:Utilities.utilities.getUserCountry(), catgoryId: Utilities.utilities.getArrCotgory()[0] as! String )
            print("country\(Utilities.utilities.getUserCountry())")
            print("country\(Utilities.utilities.getArrCotgory()[0])")
            newsViewModel?.newsObservable.subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
                .observe(on: MainScheduler.asyncInstance)
                .subscribe { news in
                    self.arrayOfArticle = news
                    print("firstnewwws\(news.count)")
                    self.newsTb.reloadData()
                    dispatchGroup.leave()
                } onError: { error in
                    print(error)
                }.disposed(by: disBag)
        }
        dispatchGroup.enter()
        func secFetchData(){
            newsViewModel?.getNewsFromApi(countryName:Utilities.utilities.getUserCountry(), catgoryId: Utilities.utilities.getArrCotgory()[1] as! String )
            print("country\(Utilities.utilities.getUserCountry())")
            print("country\(Utilities.utilities.getArrCotgory()[1])")
            newsViewModel?.newsObservable.subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
                .observe(on: MainScheduler.asyncInstance)
                .subscribe { news in
                    self.arrayOfArticle.append(contentsOf: news)
                    print("firstnewwws\(news.count)")
                    self.newsTb.reloadData()
                    dispatchGroup.leave()
                } onError: { error in
                    print(error)
                }.disposed(by: disBag)
        }
        dispatchGroup.notify(queue: .main) {
            // whatever you want to do when both are done
        }
    }
//    func fetchData(){
//        newsViewModel?.getNewsFromApi(countryName:Utilities.utilities.getUserCountry(), catgoryId: Utilities.utilities.getArrCotgory()[0] as! String )
//        print("country\(Utilities.utilities.getUserCountry())")
//        print("country\(Utilities.utilities.getArrCotgory()[0])")
//        newsViewModel?.newsObservable.subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
//            .observe(on: MainScheduler.asyncInstance)
//            .subscribe { news in
//                self.arrayOfArticle = news
//                print("newwws\(news.count)")
//                self.newsTb.reloadData()
//            } onError: { error in
//                print(error)
//            }.disposed(by: disBag)
//    }
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
        } onCompleted: {
            print("onComplete network")
        } onDisposed: {
            print("ondispose network")
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ListNewsViewController{
    func getArticlesFromCoreData(){
        do{
            try  newsViewModel?.getAllnewsInCoreData(completion: { response in
                //MARK: LSA M5LST4
                switch response{
                case true:
                    print("data retrived successfuly")
                case false:
                    print("data cant't retrieved")
                }
            })
        }
        catch let error{
            print(error.localizedDescription)
        }
        articles = (newsViewModel?.articleList)!
        newsTb.reloadData()
            }
    func deleteItemFromCoreData(index:IndexPath){
        do{
            try self.newsViewModel?.removeNewsFromCoreDatat(title: "\(arrayOfArticle[index.row].title ?? "title")", completionHandler: { result in
                switch result{
                case true:
                print("remove from cart")
                self.getArticlesFromCoreData()
                Utilities.utilities.showMessage(message: "remove from Favourite", error: false)
                self.newsTb.reloadData()
                case false:
                    print("cann't delet")
                        }
            })
        }
        catch let error{
            print(error.localizedDescription)
        }
    }
    func
    showDeleteAlert(indexPath:IndexPath){
        let alert = UIAlertController(title: "Already Saved", message: "Are You remove this item from the Fav", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { [self] UIAlertAction in
        self.deleteItemFromCoreData(index: indexPath)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
