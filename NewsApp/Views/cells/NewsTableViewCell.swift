//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Menna on 20/09/2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var shortDescription: UITextView!
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var source: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
