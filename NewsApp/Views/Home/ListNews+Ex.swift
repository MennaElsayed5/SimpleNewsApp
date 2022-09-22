//
//  ListNewsExtention.swift
//  NewsApp
//
//  Created by Menna on 22/09/2022.
//
import Kingfisher
import Foundation
extension ListNewsViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfArticle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
                let url = URL(string: arrayOfArticle[indexPath.row].urlToImage ?? "news")
                let processor = DownsamplingImageProcessor(size: cell.imgNews.bounds.size)
                             |> RoundCornerImageProcessor(cornerRadius: 20)
              //  cell.newsTitle.text = arrayOfArticle[indexPath.row].title
        cell.articleTitle.accessibilityValue = arrayOfArticle[indexPath.row].url
        cell.articleTitle.addTarget(self, action: #selector(self.titleTapped), for: .touchUpInside)
                cell.newsTitle.isUserInteractionEnabled=true
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
                cell.addToFav={ [self] in
                    newsViewModel?.checkNewsInCoreData(data: arrayOfArticle[indexPath.row].publishedAt ?? "title", auther: arrayOfArticle[indexPath.row].author ?? "auther")
                    isFav = newsViewModel?.isFav
                    if (isFav!) {
                        self.showDeleteAlert(indexPath: indexPath)
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
        
                return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
           func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
               return 60
           }
    
}
