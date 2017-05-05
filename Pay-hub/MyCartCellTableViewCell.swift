//
//  MyCartCellTableViewCell.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 01/05/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit

class MyCartCellTableViewCell: UITableViewCell {
    @IBOutlet weak var numberlabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
