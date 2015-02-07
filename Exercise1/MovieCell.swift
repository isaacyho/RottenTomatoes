//
//  MovieCell.swift
//  Exercise1
//
//  Created by Isaac Ho on 2/6/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if ( selected )
        {
            self.label.textColor = UIColor.blueColor()
        }
        else
        {
            self.label.textColor = UIColor.blackColor()
        }
    }

}
