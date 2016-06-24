//
//  PlayerViewCell.swift
//  Ratings
//
//  Created by Akshay Bhandary on 6/23/16.
//  Copyright © 2016 Akshay Bhandary. All rights reserved.
//

import UIKit

class PlayerViewCell: UITableViewCell {

    @IBOutlet weak var gameLabel : UILabel?
    @IBOutlet weak var nameLabel : UILabel?
    @IBOutlet weak var imageLabel : UIImageView?
    
    var player : Player? {
        didSet {
            gameLabel?.text = player?.game
            nameLabel?.text = player?.name
            if let player = player {
                imageLabel?.image = UIImage(named: "\(player.rating)Stars")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
