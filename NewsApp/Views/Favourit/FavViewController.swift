//
//  FavViewController.swift
//  NewsApp
//
//  Created by Menna on 20/09/2022.
//

import UIKit
import Kingfisher
class FavViewController: UIViewController {
    @IBOutlet weak var favTb: UITableView!
    var articles : [Articles] = []
    var newsViewModel : NewsProtocolViewModel?
    @IBOutlet weak var emptyView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.favTb.delegate=self
        self.favTb.dataSource=self
        let newsCell = UINib(nibName: "NewsTableViewCell", bundle: nil)
        favTb.register(newsCell, forCellReuseIdentifier: "NewsTableViewCell")
        newsViewModel=NewsViewModel()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        getArticlesFromCoreData()
        if articles.isEmpty {
            self.emptyView.isHidden=false
        }else{
            self.emptyView.isHidden=true

        }
    }
    func getArticlesFromCoreData(){
        do{
            try  newsViewModel?.getAllnewsInCoreData(completion: { response in
                switch response{
                case true:
                    print("data retrived successfuly")
                case false:
                    print("data cant't retrieved")
                }})
        }
        catch let error{
            print(error.localizedDescription)
        }
        articles = (newsViewModel?.articleList)!
        favTb.reloadData()
            }
    func deleteItemFromCoreData(index:IndexPath){
        do{
            try self.newsViewModel?.removeNewsFromCoreDatat(title: "\(articles[index.row].articleTitle ?? "title")", completionHandler: { result in
                switch result{
                 case true:
                print("remove from cart")
                self.getArticlesFromCoreData()
                Utilities.utilities.showMessage(message: "remove from Favourite", error: false)
                    self.favTb.reloadData()
                    if self.articles.count == 0 {
                    self.emptyView.isHidden=false
                    }
                case false:
                print("can't delet")
             }
            })
        }
        catch let error{
            print(error.localizedDescription)
        }
    }
    func showDeleteAlert(indexPath:IndexPath){
        let alert = UIAlertController(title: "Are you sure?", message: "You will remove this item from the Fav", preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
         alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { [self] UIAlertAction in
         self.deleteItemFromCoreData(index: indexPath)}))
         self.present(alert, animated: true, completion: nil)
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
