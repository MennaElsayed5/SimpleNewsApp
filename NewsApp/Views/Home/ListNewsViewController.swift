//
//  ListNewsViewController.swift
//  NewsApp
//
//  Created by Menna on 20/09/2022.
//

import UIKit
import RxSwift
import Kingfisher
class ListNewsViewController: UIViewController {
    var countryName:String?
    var catgory:String?
    var tabBarView:TabBarViewController?
    @IBOutlet weak var newsTb: UITableView!
    var newsViewModel: NewsViewModel?
    let disBag = DisposeBag()
    var arrayOfArticle: [Article] = []
    var articles : [Articles] = []
    var artile:Article?
    var isFav : Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("naamm\(countryName)naaaaaam\(catgory)")
        newsViewModel = NewsViewModel(appDelegate: ((UIApplication.shared.delegate as? AppDelegate)!))
        self.newsTb.delegate=self
        self.newsTb.dataSource=self
        let newsCell = UINib(nibName: "NewsTableViewCell", bundle: nil)
        newsTb.register(newsCell, forCellReuseIdentifier: "NewsTableViewCell")
        fetchData()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        getArticlesFromCoreData()

    }
    func fetchData(){
        newsViewModel?.getNewsFromApi(countryName:countryName ?? "us", catgoryId: catgory ?? "general")
    //    newsViewModel?.allNews()
        newsViewModel?.newsObservable.subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { news in
                self.arrayOfArticle = news
              //  self.artile=news.element[]
                print("newwws\(news.count)")
                self.newsTb.reloadData()
            } onError: { error in
                print(error)
            }.disposed(by: disBag)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc private func longPress(recognizer: UIButton) {
        newsViewModel?.checkNewsInCoreData(data: "\(arrayOfArticle[recognizer.tag].publishedAt ?? "date")", auther: "\(arrayOfArticle[recognizer.tag].author ?? "auther")")
            if newsViewModel?.isFav == false {
                do{
                    try newsViewModel?.saveoCoreData(title: arrayOfArticle[recognizer.tag].title ?? "title", img: arrayOfArticle[recognizer.tag].urlToImage ?? "news", desc:arrayOfArticle[recognizer.tag].description ?? "des", source: arrayOfArticle[recognizer.tag].source?.name ?? "source", data: arrayOfArticle[recognizer.tag].publishedAt ?? "2022/9/23", auther: arrayOfArticle[recognizer.tag].author ?? "auther", completion: { [self]  result in
                    switch result{
                    case true:
                        print("arrayOfArticle[recognizer.tag].title \(arrayOfArticle[recognizer.tag].title)")
                        print("arrayOfArticle[recognizer.tag].title \(arrayOfArticle[recognizer.tag].source?.name)")

                    print("add to core ")
                        case false :
                        print("faild to add to core")
                                }
                                })
                            }

                    catch let error{
                print(error.localizedDescription)
                                  }
                recognizer.setImage(UIImage(systemName: "heart.fill"), for : UIControl.State.normal)
            }
            else{
                print("in core data ")
                recognizer.setImage(UIImage(systemName: "heart"), for : UIControl.State.normal)

            }


      }
    func getArticlesFromCoreData(){
        do{
            try  newsViewModel?.getAllnewsInCoreData(completion: { response in
                //MARK: LSA M5LST4
                switch response{
                case true:
//                    self.emptyView.isHidden=true
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
        print("arrrry\(arrayOfArticle)")
        newsTb.reloadData()
            }
    func deleteItemFromCoreData(index:IndexPath){
        do{
            try self.newsViewModel?.removeNewsFromCoreDatat(title: "\(arrayOfArticle[index.row].title ?? "title")", completionHandler: { result in
                switch result{
                                case true:
                                    print("remove from cart")
                                   self.getArticlesFromCoreData()
                                   self.newsTb.reloadData()
                                   // if self.CartProducts.count == 0 {
                                    //self.emptyView.isHidden=false
                case false:
                    print("")
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
    func setupBtn(btn:UIButton){
        if newsViewModel?.isFav == false {
            btn.setImage(UIImage(systemName: "heart"), for : UIControl.State.normal)
        }else{
            btn.setImage(UIImage(systemName: "heart.fill"), for : UIControl.State.normal)
        }
    }
}
extension ListNewsViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("arrayOfArticle.count\(arrayOfArticle.count)")
        return arrayOfArticle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
        let url = URL(string: arrayOfArticle[indexPath.row].urlToImage ?? "news")
        let processor = DownsamplingImageProcessor(size: cell.imgNews.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        cell.newsTitle.text = arrayOfArticle[indexPath.row].title
        cell.imgNews.kf.indicatorType = .activity
        cell.imgNews.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        cell.imgNews.layer.borderWidth = 1
        cell.imgNews.layer.borderColor = UIColor.lightGray.cgColor
        cell.imgNews.layer.cornerRadius = 20
        cell.shortDescription.text=arrayOfArticle[indexPath.row].description
        cell.source.text = arrayOfArticle[indexPath.row].source?.name
        cell.date.text = arrayOfArticle[indexPath.row].publishedAt
       // setupBtn(btn: cell.favBtn)
       // cell.tag = indexPath.row
        cell.addToFav={ [self] in
            newsViewModel?.checkNewsInCoreData(data: arrayOfArticle[indexPath.row].publishedAt ?? "title", auther: arrayOfArticle[indexPath.row].author ?? "auther")
            isFav = newsViewModel?.isFav
            if (isFav!) {
                self.showDeleteAlert(indexPath: indexPath)
                print("alreadyIsFav\(isFav)")
            }else{
                do{
                    try newsViewModel?.saveoCoreData(title: arrayOfArticle[indexPath.row].title ?? "title", img: arrayOfArticle[indexPath.row].urlToImage ?? "news", desc:arrayOfArticle[indexPath.row].description ?? "des", source: arrayOfArticle[indexPath.row].source?.name ?? "source", data: arrayOfArticle[indexPath.row].publishedAt ?? "2022/9/23", auther: arrayOfArticle[indexPath.row].author ?? "auther", completion: {  result in
                          switch result{
                          case true:
                              print("add to core ")
                          case false :
                              print("faild to add to core")
                          }
                      })
                  }

              catch let error{
                      print(error.localizedDescription)
                  }

            }


        }
  
   //   cell.favBtn.addTarget(self, action: #selector(longPress(recognizer:)), for: .touchUpInside)
   //    cell.favBtn.accessibilityValue=arrayOfArticle[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
            return 230
       }
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 60
       }
    
}
