//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Menna on 20/09/2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var articleTitle: UIButton!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var shortDescription: UITextView!
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    var addToFav:()->() = {}
    var newsViewModel:NewsViewModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        newsViewModel = NewsViewModel(appDelegate: ((UIApplication.shared.delegate as? AppDelegate)!))

    }

    @IBAction func pressFav(_ sender: Any) {
        addToFav()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
