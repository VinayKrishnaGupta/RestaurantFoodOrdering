//
//  MenuGroupsVC.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 18/04/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import Alamofire



class MenuGroupsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var CollectionViewMenuGroups: UICollectionView!
    var menugroups : NSArray = []
    var SelectedMenuGroup : NSDictionary = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionViewMenuGroups.dataSource = self
        CollectionViewMenuGroups.delegate = self
        self.navigationItem.title = "Menu"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        let script = GetDatafromAPI()
       
        let dict1 = script.getDataofGETcall(URLString: "https://pay-hub.in/payhub%20api/v1/menu_group.php")
        print("Dictionary is \(String(describing: dict1))")
        self.menugroups = (dict1?.value(forKeyPath: "Response.data.menu") as? NSArray)!
        self.CollectionViewMenuGroups.reloadData()
//        let HEADERS: HTTPHeaders = [
//            "Token": "d75542712c868c1690110db641ba01a",
//            "Accept": "application/json",
//            "user_name" : "admin",
//            "user_id" : "3"
//        ]
//        Alamofire.request(
//            URL(string: "https://pay-hub.in/payhub%20api/v1/menu_group.php")!,
//            method: .get,
//            parameters: nil,
//            headers: HEADERS
//            )
//            .validate()
//            
//            .responseJSON { response in
//                debugPrint(response)
//                
//                
//                if let json = response.result.value {
//                    let dict = json as! NSDictionary
//                    print("Converted Dictionary is \(dict)")
//                    self.menugroups = dict.value(forKeyPath: "Response.data.menu") as! NSArray
//                    print("Menu group list is \(String(describing: self.menugroups))")
//                    self.CollectionViewMenuGroups.reloadData()
//                    
//                }
//                
//        }
//
        
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menugroups.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionViewMenuGroups.dequeueReusableCell(withReuseIdentifier: "MenuGroupsCollectionViewCell", for: indexPath) as! MenuGroupsCollectionViewCell
        let dict : NSDictionary = menugroups[indexPath.row] as! NSDictionary
        cell.cellImageView.image = UIImage.init(named: "MenuGroupssample")
        cell.titleLabel.text = dict.value(forKey: "menu_title") as? String
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        SelectedMenuGroup = menugroups[indexPath.row] as! NSDictionary
        self.performSegue(withIdentifier: "itemDetails", sender: self)
      
        
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemDetails" {
            if let nextViewController = segue.destination as? MenuItemListViewController{
             nextViewController.selectedGroup = SelectedMenuGroup
            }
            
        }
        
        
    }
    

}
