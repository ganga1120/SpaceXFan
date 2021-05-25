//
//  UpcomingLaunchesCell.swift
//  SpaceXFan
//
//  Created by ggajulapati on 22/05/21.
//

import UIKit
import SDWebImage

class UpcomingLaunchesCell: UITableViewCell {

    @IBOutlet weak var nameLable :UILabel!
    @IBOutlet weak var desciptionLable: UILabel!
    
    var seletedUpcomingLaunchesItem :UpcomingLaunchesListModel? {
        didSet {
            self.nameLable.text = seletedUpcomingLaunchesItem?.name
            self.desciptionLable.text = seletedUpcomingLaunchesItem?.details
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
