//
//  MenuItemListViewController.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 18/04/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import Alamofire

class MenuItemListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var CollectionViewList: UICollectionView!
    public var selectedGroup: NSDictionary = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionViewList.dataSource = self
        CollectionViewList.delegate = self
        
        self.navigationItem.title = "Veg Starters"
        print("Selected Dictionary group is \(selectedGroup)")
        
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let HEADERS: HTTPHeaders = [
            "Token": "d75542712c868c1690110db641ba01a",
            "Accept": "application/json",
            "user_name" : "admin",
            "user_id" : "3"
        ]
        Alamofire.request(
            URL(string: "https://pay-hub.in/payhub%20api/v1/menu_group.php")!,
            method: .get,
            parameters: nil,
            headers: HEADERS
            )
            .validate()
            
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                   
                    
                }
                
        }
        
        
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
    

}
