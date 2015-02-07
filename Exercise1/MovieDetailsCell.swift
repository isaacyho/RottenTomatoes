//
//  MovieDetailsCell.swift
//  Exercise1
//
//  Created by Isaac Ho on 2/6/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class MovieDetailsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var scoresLabel: UILabel!
    @IBOutlet weak var synopsisTextView: UITextView!
    @IBOutlet weak var imgView: UIImageView!
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
