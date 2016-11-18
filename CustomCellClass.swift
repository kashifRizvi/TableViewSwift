//
//  CustomCellClass.swift
//  CustomTableSwift
//
//  Created by Kashif on 17/11/16.
//  Copyright © 2016 Kashif. All rights reserved.
//

import UIKit

class CustomCellClass: UITableViewCell {

    @IBOutlet weak var marks: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageViewCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
