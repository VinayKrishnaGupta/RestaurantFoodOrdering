//
//  getAddressTableViewCell.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 23/05/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit

class getAddressTableViewCell: UITableViewCell {
    @IBOutlet weak var address1label: UILabel!
    @IBOutlet weak var address2label: UILabel!
    @IBOutlet weak var address3label: UILabel!
    @IBOutlet weak var editAddress: UIButton!
    @IBOutlet weak var deleteAddress: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
