//
//  SearchView+Ex.swift
//  NewsApp
//
//  Created by Menna on 22/09/2022.
//

import Foundation
import Kingfisher
extension SearchViewController: UITableViewDelegate,UITableViewDataSource{
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
