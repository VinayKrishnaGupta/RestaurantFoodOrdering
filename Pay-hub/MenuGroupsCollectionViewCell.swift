//
//  MenuGroupsCollectionViewCell.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 18/04/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit

class MenuGroupsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        let topColor = UIColor.clear
        let bottomColor = UIColor.black
        
        
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        
        let gradientLoactions: [Float] = [0.7, 1.0]
        
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        
        gradientLayer.colors = gradientColors
        
        gradientLayer.locations = gradientLoactions as [NSNumber]
        
        
        gradientLayer.frame = self.cellImageView.bounds
        
        
        self.cellImageView.layer.insertSublayer(gradientLayer, at: 0)
        
        
        
        
        
    }
    
    
}
