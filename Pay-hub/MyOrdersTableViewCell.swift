//
//  MyOrdersTableViewCell.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 05/06/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit

class MyOrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var transactionIDLabel: UILabel!
    @IBOutlet weak var OrderStatusLabel: UILabel!
    @IBOutlet weak var orderListLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var OrderPriceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
