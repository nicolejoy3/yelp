//
//  mainTableViewCell.swift
//  instagram_demo
//
//  Created by Elizabeth on 2/23/18.
//  Copyright © 2018 Elizabeth. All rights reserved.
//

import UIKit
import Parse

class mainPhotoCell: UITableViewCell {


    @IBOutlet weak var postedPicImageView: UIImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    
    var userPost: PFObject!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
