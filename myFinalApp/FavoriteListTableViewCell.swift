//
//  FavoriteListTableViewCell.swift
//  myFinalApp
//
//  Created by user_09 on 2017/6/19.
//  Copyright © 2017年 GragHIO. All rights reserved.
//

import UIKit

class FavoriteListTableViewCell: UITableViewCell {

    @IBOutlet weak var songImg: UIImageView!
    @IBOutlet weak var songName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
