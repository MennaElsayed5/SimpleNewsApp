//
//  CatgoryTableViewCell.swift
//  NewsApp
//
//  Created by Menna on 21/09/2022.
//

import UIKit

class CatgoryTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
