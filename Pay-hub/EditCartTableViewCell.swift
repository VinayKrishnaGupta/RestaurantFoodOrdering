//
//  EditCartTableViewCell.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 02/06/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import GMStepper

class EditCartTableViewCell: UITableViewCell {
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemCountStepper: GMStepper!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
