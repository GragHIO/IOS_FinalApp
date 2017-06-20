//
//  SongListTableViewCell.swift
//  myFinalApp
//
//  Created by user_09 on 2017/6/14.
//  Copyright © 2017年 GragHIO. All rights reserved.
//

import UIKit

class SongListTableViewCell: UITableViewCell {

    @IBOutlet weak var SongImg: UIImageView!
    @IBOutlet weak var SongName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
