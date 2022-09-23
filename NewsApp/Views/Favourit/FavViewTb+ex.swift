//
//  FavView+ex.swift
//  NewsApp
//
//  Created by Menna on 22/09/2022.
//

import Foundation
import Kingfisher
extension FavViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
               let url = URL(string: articles[indexPath.row].articleImg ?? "news")
               let processor = DownsamplingImageProcessor(size: cell.imgNews.bounds.size)
                            |> RoundCornerImageProcessor(cornerRadius: 20)
               cell.newsTitle.text = articles[indexPath.row].articleTitle
               cell.imgNews.kf.indicatorType = .activity
               cell.imgNews.kf.setImage(
                   with: url,
                   placeholder: UIImage(named: "news"),
                   options: [
                       .processor(processor),
                       .scaleFactor(UIScreen.main.scale),
                       .transition(.fade(1)),
                       .cacheOriginalImage
                   ])
               cell.imgNews.layer.borderWidth = 1
               cell.imgNews.layer.borderColor = UIColor.lightGray.cgColor
               cell.imgNews.layer.cornerRadius = 20
               cell.shortDescription.text=articles[indexPath.row].articleDesc
               cell.source.text = articles[indexPath.row].articleSource
               cell.date.text = articles[indexPath.row].articleData
               cell.addToFav = {
                   self.showDeleteAlert(indexPath: indexPath)
               }
               cell.favBtn.setTitle("", for: .normal)
               cell.favBtn.setImage(UIImage(systemName: "trash"), for : UIControl.State.normal)
               return cell
           }
           func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
                   return 230
              }
              func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
                  return 60
              }
    
    
}
