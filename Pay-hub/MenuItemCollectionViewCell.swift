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
  
    
    
    override func awakeFromNib() {
        let topColor = UIColor.clear
        let bottomColor = UIColor.black
        
        
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        
        let gradientLoactions: [Float] = [0.7, 1.0]
        
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        
        gradientLayer.colors = gradientColors
        
        gradientLayer.locations = gradientLoactions as [NSNumber]
        
        
        gradientLayer.frame = self.itemImageView.bounds
        
        
        self.itemImageView.layer.insertSublayer(gradientLayer, at: 0)


        
    }
    
    
    
}
