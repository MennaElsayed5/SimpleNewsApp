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
    @IBOutlet weak var newsTb: UITableView!
    var newsViewModel: NewsViewModel?
    let disBag = DisposeBag()
    var arrayOfArticle: [Articles] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        newsViewModel = NewsViewModel(appDelegate: ((UIApplication.shared.delegate as? AppDelegate)!))
        self.newsTb.delegate=self
             self.newsTb.dataSource=self
        let newsCell = UINib(nibName: "NewsTableViewCell", bundle: nil)
        newsTb.register(newsCell, forCellReuseIdentifier: "NewsTableViewCell")
        fetchData()
        // Do any additional setup after loading the view.
    }
    func fetchData(){
       newsViewModel?.getNewsFromApi(countryName: "us", catgoryId: "entertainment")
    //    newsViewModel?.allNews()
        newsViewModel?.newsObservable.subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { news in
                self.arrayOfArticle = news
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
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
            return 230
       }
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 60
       }
    
}
