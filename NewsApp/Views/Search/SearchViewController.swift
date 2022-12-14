//
//  SearchViewController.swift
//  NewsApp
//
//  Created by Menna on 20/09/2022.
//

import UIKit
import RxSwift
import Kingfisher
class SearchViewController: UIViewController,UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchTb: UITableView!
    var newsViewModel: NewsProtocolViewModel?
    fileprivate let disBag = DisposeBag()
    var arrayOfArticle: [Article] = []
    private  var isConn:Bool = false
    var articles : [Articles] = []
    var isFav : Bool?
    private  let refreshController = UIRefreshControl()
    @IBOutlet weak var noSershView: UIView!
    @IBOutlet weak var noConnctionView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        newsViewModel = NewsViewModel()
        self.searchTb.delegate=self
             self.searchTb.dataSource=self
        let newsCell = UINib(nibName: "NewsTableViewCell", bundle: nil)
        searchTb.register(newsCell, forCellReuseIdentifier: "NewsTableViewCell")
        searchBar.delegate=self
        refreshController.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        searchTb.addSubview(refreshController)
    }
    
    func searchRequest(){
        newsViewModel?.searchArticales(text: "\(searchBar.text ?? "news")")
        newsViewModel?.searchObservable.subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { news in
                if news.count == 0 {
                    self.noSershView.isHidden=false
                }
                else{
                    self.noSershView.isHidden=true
                    self.arrayOfArticle = news
                    print("newwws\(news.count)")
                    self.searchTb.reloadData()
                }
            } onError: { error in
                print(error)
            }.disposed(by: disBag)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       checkNetwork()
    }
    func checkNetwork() {
        newsViewModel?.checkConnection()
        newsViewModel?.networkObservable.subscribe {[weak self] isConn in
            self?.isConn = isConn
            if isConn == false{
               self?.noConnctionView.isHidden = false
                self?.noSershView.isHidden=true
            }else{
               self?.noConnctionView.isHidden = true
                self?.noSershView.isHidden=false

                self?.searchRequest()
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

