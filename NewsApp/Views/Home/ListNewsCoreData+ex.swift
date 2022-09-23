//
//  ListNewsCoreData+ex.swift
//  NewsApp
//
//  Created by Menna on 23.9.22.
//

import Foundation
import UIKit
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
    func checkIsFav(indexPath:IndexPath){
        newsViewModel?.checkNewsInCoreData(data: arrayOfArticle[indexPath.row].publishedAt ?? "title", auther: arrayOfArticle[indexPath.row].author ?? "auther")
    }
    func saveToCoreData(indexPath:IndexPath){
        do{
            try newsViewModel?.saveoCoreData(title: arrayOfArticle[indexPath.row].title ?? "title", img: arrayOfArticle[indexPath.row].urlToImage ?? "news", desc:arrayOfArticle[indexPath.row].description ?? "des", source: arrayOfArticle[indexPath.row].source?.name ?? "source", data: arrayOfArticle[indexPath.row].publishedAt ?? "2022/9/23", auther: arrayOfArticle[indexPath.row].author ?? "auther", completion: {  result in
                  switch result{
                  case true:
                      Utilities.utilities.showMessage(message: "added to Favourite", error: false)
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
