//
//  MenuGroupsVC.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 18/04/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit

class MenuGroupsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var CollectionViewMenuGroups: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionViewMenuGroups.dataSource = self
        CollectionViewMenuGroups.delegate = self
        self.navigationItem.title = "Menu"
        // Do any additional setup after loading the view.
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionViewMenuGroups.dequeueReusableCell(withReuseIdentifier: "MenuGroupsCollectionViewCell", for: indexPath) as! MenuGroupsCollectionViewCell
        
        
        cell.cellImageView.image = UIImage.init(named: "MenuGroupssample")
        cell.titleLabel.text = "Veg Starters"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            self.performSegue(withIdentifier: "itemDetails", sender: self)
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
