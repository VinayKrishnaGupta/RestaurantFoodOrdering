//
//  MenuItemListViewController.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 18/04/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit

class MenuItemListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var CollectionViewList: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionViewList.dataSource = self
        CollectionViewList.delegate = self
        
        self.navigationItem.title = "Veg Starters"
        
        

        // Do any additional setup after loading the view.
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
         return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionViewList.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MenuItemCollectionViewCell
        if indexPath.row == 0
        {
            cell.itemImageView.image = UIImage.init(named: "rollimage")
            cell.itemtName.text = "Veg Wrap"
            cell.itemdescripion.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry"
            cell.priceLabel.text = "₹ 199"
            return cell
        }
        else {
        cell.itemImageView.image = UIImage.init(named: "homescreenbg")
        cell.itemtName.text = "Veg Pizza"
        cell.itemdescripion.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry"
        cell.priceLabel.text = "₹ 349"
        return cell
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
