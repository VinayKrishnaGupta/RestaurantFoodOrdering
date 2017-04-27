//
//  MenuItemListViewController.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 18/04/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import GMStepper


class MenuItemListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet var CollectionViewList: UICollectionView!
    var badgenumber : Int = 0
    var FinalBadgeNumber : Int = 0
    var SavedIndexpath: Int? = nil
    var SelectedItems : Array<Any> = []
    var numberofItems : Array<Int>   = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CollectionViewList.dataSource = self
      //  self.CollectionViewList.delegate = self
        
        
        self.navigationItem.title = "Veg Starters"
        print("Selected Dictionary group is \(selectedGroup)")
        
        let sharedInstance1 = CartManager.sharedInstance
        print("String 1 from Singleton is \(sharedInstance1.strSample)")
        sharedInstance1.strSample = "Hello Vinay"
        
        let sharedInstance2 = CartManager.sharedInstance
        print("String 2 from singleton 2 is \(sharedInstance2.strSample)")
        
        
        
        
        // Do any additional setup after loading the view.
    }

    
    
 
    

   
    @IBAction func valueChanged(_ sender: GMStepper) {
    
        print("Value changed )")
        let pos = (sender as AnyObject).convert(CGPoint.zero, to: CollectionViewList)
        let indexPath = CollectionViewList.indexPathForItem(at: pos)!
        
        guard let cell: MenuItemCollectionViewCell = (CollectionViewList.cellForItem(at: indexPath)) as? (MenuItemCollectionViewCell)
            else
        {
            print("Can't deque cells")
            return
        }

        
        
        let value = String(Int(cell.itemGMStepper.value))
        let value2 = String(Int(cell.itemGMStepper.stepValue))
        print("Changed Value is \(value)")
        print("Step Value is \(value2)")
        
        
        
        
        
        if SavedIndexpath == indexPath.row
        {
            if numberofItems[indexPath.row] >=  Int(cell.itemGMStepper.value)  {
                
                FinalBadgeNumber = FinalBadgeNumber - Int(cell.itemGMStepper.stepValue)
                badgenumber = badgenumber - Int(cell.itemGMStepper.stepValue)
               // let dict = self.itemArray[indexPath.row]
                self.numberofItems[indexPath.row] = badgenumber
               // self.SelectedItems.insert(dict, at: indexPath.row)
            }
            else {
                
                FinalBadgeNumber = FinalBadgeNumber + Int(cell.itemGMStepper.stepValue)
                badgenumber = badgenumber + Int(cell.itemGMStepper.stepValue)
               // let dict = self.itemArray[indexPath.row]
                self.numberofItems[indexPath.row] = badgenumber
             //   self.SelectedItems.insert(dict, at: indexPath.row)
            }
            
        }
        
        else
        {
       
        if numberofItems[indexPath.row] >=  Int(cell.itemGMStepper.value)  {
            badgenumber = 0
            FinalBadgeNumber = FinalBadgeNumber - Int(cell.itemGMStepper.stepValue)
             badgenumber = badgenumber - Int(cell.itemGMStepper.stepValue)
            let dict = self.itemArray[indexPath.row]
            self.numberofItems[indexPath.row] = badgenumber
            self.SelectedItems[indexPath.row] = dict
        }
        else {
             badgenumber = 0
            FinalBadgeNumber = FinalBadgeNumber + Int(cell.itemGMStepper.stepValue)
            badgenumber = badgenumber + Int(cell.itemGMStepper.stepValue)
            let dict = self.itemArray[indexPath.row]
            self.numberofItems[indexPath.row] = badgenumber
            self.SelectedItems[indexPath.row] = dict
            
        }
            
        }
        SavedIndexpath = indexPath.row
        
      //  cell.itemGMStepper.value = Double(numberofItems[indexPath.row])
        
        let SharedInstance = CartManager.sharedInstance
        SharedInstance.MyCartItems = SelectedItems
        
        print("Selected Items are \(SelectedItems)")
        print("Number of Items are \(numberofItems)")
        let addedvalue : [String : NSDictionary] = ["SelectedItem" : SelectedItems[indexPath.row] as! NSDictionary]
    //    NotificationCenter.default.post(name: Notification.Name("NumberofaddedItems"), object: numberofItems,)
      //  NotificationCenter.default.post(name: Notification.Name("NumberofaddedItems"), object: nil, userInfo: addedvalue)
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: addedvalue)
        
    //       let item = itemArray[indexPath.row]
   //        (item as AnyObject).value[3] = value
//            cart[indexPath.row] = item
//      
     //   print("Changed Value is \(value)")
        
     //   var i : String = "0"
      //  i = i + (cell.itemGMStepper.value as? String)!
        tabBarController?.tabBar.items![1].badgeValue =  "\(FinalBadgeNumber)"
        
        

        
        
    }
    
    func updateBadgeNumberonTab() {
        
    }
    
    public var selectedGroup: NSDictionary = [:]
    var itemArray : NSArray = []

    
    override func viewWillAppear(_ animated: Bool) {
       // SelectedItems.removeAll()
        //numberofItems.removeAll()
        let HEADERS: HTTPHeaders = [
            "Token": "d75542712c868c1690110db641ba01a",
            "Accept": "application/json",
            "user_name" : "admin",
            "user_id" : "3"
        ]
        
        let MenuID : String = selectedGroup.value(forKey: "menu_id") as! String
        let Parameters = ["menu_id":MenuID] 
        
        //create the url with URL
        Alamofire.request(
            URL(string: "https://pay-hub.in/payhub%20api/v1/item_detail.php")!,
            method: .post,
            parameters: Parameters,
            headers: HEADERS
            )
            .validate()
            
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    self.itemArray = (dict.value(forKeyPath: "Response.data.item") as? NSArray)!
                    print("Response Time  of Item is \(response.timeline)")
                    self.CollectionViewList.reloadData()
                    for _ in 0..<self.itemArray.count {
                        self.numberofItems.append(0)
                        self.SelectedItems.append(0)
                    }

                    
                }
                
        }
        
        
    }

    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
         return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionViewList.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MenuItemCollectionViewCell
        
        let dict = itemArray[indexPath.row] as? NSDictionary
        let imageaddress  = dict?.value(forKey: "item_image") as! String
        let imageURL = String(format: "https://pay-hub.in/tpl/web_admin_3/img/%@",imageaddress)
        cell.itemImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "loading"))
        
        
        
        
        
        
        
//        let imageURL = String(format: "https://pay-hub.in/tpl/web_admin_3/img/%@",imageaddress)
//        let url = NSURL(string:imageURL)
//        let data = NSData(contentsOf: (url as URL?)!)
//        cell.itemImageView.image = UIImage(data:(data as Data?)!)
        
        
        cell.itemtName.text = dict?.value(forKey: "item_name") as? String
        cell.itemdescripion.text = dict?.value(forKey: "item_content") as? String
        cell.itemGMStepper.value = Double(self.numberofItems[indexPath.row])
        cell.itemGMStepper.addTarget(self, action: #selector(valueChanged(_:)), for: UIControlEvents.valueChanged)
        
        let pricestring = String(format: " ₹ %@", (dict?.value(forKey: "item_price") as? String)!)
        cell.priceLabel.text = pricestring
        return cell
        
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    

}
