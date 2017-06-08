//
//  MenuItemCollectionViewCell.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 18/04/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import GMStepper

class MenuItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    

    @IBOutlet weak var itemtName: UILabel!
    @IBOutlet weak var itemdescripion: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var itemGMStepper: GMStepper!
  
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    
    override func awakeFromNib() {
        
        self.contentView.autoresizingMask.insert(.flexibleHeight)
        self.contentView.autoresizingMask.insert(.flexibleWidth)
        let topColor = UIColor.clear
        let bottomColor = UIColor.black
        
        
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        
        let gradientLoactions: [Float] = [0.6, 1.0]
        
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        
        gradientLayer.colors = gradientColors
        
        gradientLayer.locations = gradientLoactions as [NSNumber]
        
        
        gradientLayer.frame = self.itemImageView.frame
        
        
        self.itemImageView.layer.insertSublayer(gradientLayer, at: 0)
       

        
        


        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
//        self.itemtName.text = ""
//        self.itemImageView.image = UIImage.init(named: "")
//        self.itemGMStepper.value = 0
//        self.itemdescripion.text = ""
        
    }
    
    
    
    
}
