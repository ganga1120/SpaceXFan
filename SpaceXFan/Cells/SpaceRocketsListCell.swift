//
//  SpaceRocketsListCell.swift
//  SpaceXFan
//
//  Created by ggajulapati on 22/05/21.
//

import UIKit
import SDWebImage

class SpaceRocketsListCell: UITableViewCell {

    @IBOutlet weak var nameLable :UILabel!
    @IBOutlet weak var spactRocketImageView :UIImageView!
    @IBOutlet weak var favBtn: UIButton!
    
    var seletedSpaceRocketItem :SpaceRocketsListModel? {
        didSet {
            self.nameLable.text = seletedSpaceRocketItem?.name
            
            if seletedSpaceRocketItem?.flickr_images?.count ?? 0 > 1 {
                if let url = seletedSpaceRocketItem?.flickr_images?[0] {
                    spactRocketImageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"))
                }
            }

            if let isfav = seletedSpaceRocketItem?.isFavorite {
                if isfav {
                    favBtn.isSelected = true
                }else {
                    favBtn.isSelected = false
                }
            }else {
                favBtn.isSelected = false
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.spactRocketImageView.layer.cornerRadius = self.spactRocketImageView.frame.size.width / 2
        self.spactRocketImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
