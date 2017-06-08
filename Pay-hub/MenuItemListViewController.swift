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
import SVProgressHUD


class MenuItemListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet var CollectionViewList: UICollectionView!
    var badgenumber : Int = 0
    var FinalBadgeNumber : Int = 0 
    var SavedIndexpath: Int? = nil
    var SelectedItems : Array<Any> = []
    var numberofItems : Array<Int>   = []
    var ItemIDofSelected : String = ""
    public var selectedGroup: NSDictionary = [:]
    var itemArray : NSArray = []

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        SVProgressHUD.setRingRadius(25)
        CollectionViewList.dataSource = self
        CollectionViewList.delegate = self
        
       // navigationItem.title = "Hello"
    //    self.navigationItem.title = selectedGroup.value(forKey: "menu_title") as? String
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
        let dict = itemArray[indexPath.row] as? NSDictionary
        ItemIDofSelected = (dict?.value(forKey: "item_id") as? String)!
        
        
        guard let cell: MenuItemCollectionViewCell = (CollectionViewList.cellForItem(at: indexPath)) as? (MenuItemCollectionViewCell)
            else
        {
            print("Can't deque cells")
            return
        }

        
        
//        let value = String(Int(cell.itemGMStepper.value))
//        let value2 = String(Int(cell.itemGMStepper.stepValue))
//        print("Changed Value is \(value)")
//        print("Step Value is \(value2)")
        
        
        
        
        
        if SavedIndexpath == indexPath.row
        {
            if numberofItems[indexPath.row] >=  Int(cell.itemGMStepper.value)  {
                
                FinalBadgeNumber = FinalBadgeNumber - Int(cell.itemGMStepper.stepValue)
                badgenumber = badgenumber - Int(cell.itemGMStepper.stepValue)
               // let dict = self.itemArray[indexPath.row]
                self.numberofItems[indexPath.row] = badgenumber
                print("number 1 of items at indexpath is \(numberofItems[indexPath.row])")
                let SharedInstance1 = CartManager.sharedInstance
                SharedInstance1.numberofItemsinCartManager(Change: -1)
                self.ItemUpdateonServer(PlusorMinus: "minus")
                
               // self.SelectedItems.insert(dict, at: indexPath.row)
            }
            else {
                
                FinalBadgeNumber = FinalBadgeNumber + Int(cell.itemGMStepper.stepValue)
                badgenumber = badgenumber + Int(cell.itemGMStepper.stepValue)
               // let dict = self.itemArray[indexPath.row]
                self.numberofItems[indexPath.row] = badgenumber
                print("number 2 of items at indexpath is \(numberofItems[indexPath.row])")
                let SharedInstance1 = CartManager.sharedInstance
                SharedInstance1.numberofItemsinCartManager(Change: 1)
                self.ItemUpdateonServer(PlusorMinus: "plus")
                
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
            self.numberofItems[indexPath.row] = Int(cell.itemGMStepper.value)
            print("number 3 of items at indexpath is \(numberofItems[indexPath.row])")
            self.SelectedItems[indexPath.row] = dict
            let SharedInstance1 = CartManager.sharedInstance
            SharedInstance1.numberofItemsinCartManager(Change: -1)
            self.ItemUpdateonServer(PlusorMinus: "minus")
        }
        else {
             badgenumber = 0
            FinalBadgeNumber = FinalBadgeNumber + Int(cell.itemGMStepper.stepValue)
            badgenumber = badgenumber + Int(cell.itemGMStepper.stepValue)
            let dict = self.itemArray[indexPath.row]
            self.numberofItems[indexPath.row] = badgenumber
            print("number 4 of items at indexpath is \(numberofItems[indexPath.row])")
            self.SelectedItems[indexPath.row] = dict
            let SharedInstance1 = CartManager.sharedInstance
            SharedInstance1.numberofItemsinCartManager(Change: 1)
            self.ItemUpdateonServer(PlusorMinus: "plus")
            
        }
            
        }
        SavedIndexpath = indexPath.row
        
      //  cell.itemGMStepper.value = Double(numberofItems[indexPath.row])
        
        let SharedInstance = CartManager.sharedInstance
        SharedInstance.MyCartItems = SelectedItems
        
//        print("Selected Items are \(SelectedItems)")
//        print("Number of Items are \(numberofItems)")
//        let addedvalue : [String : NSDictionary] = ["SelectedItem" : SelectedItems[indexPath.row] as! NSDictionary]
    //    NotificationCenter.default.post(name: Notification.Name("NumberofaddedItems"), object: numberofItems,)
      //  NotificationCenter.default.post(name: Notification.Name("NumberofaddedItems"), object: nil, userInfo: addedvalue)
//         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: nil, userInfo: addedvalue)
        
    //       let item = itemArray[indexPath.row]
   //        (item as AnyObject).value[3] = value
//            cart[indexPath.row] = item
//      
     //   print("Changed Value is \(value)")
        
     //   var i : String = "0"
      //  i = i + (cell.itemGMStepper.value as? String)!
        
        let SharedInstance1 = CartManager.sharedInstance
        let numberOfIteminCartManager = SharedInstance1.numberofItemsinCartManager(Change: 0)
        let CartNumber = numberOfIteminCartManager
        tabBarController?.tabBar.items![1].badgeValue =  "\(CartNumber)"
        if #available(iOS 10.0, *) {
            tabBarController?.tabBar.items![1].badgeColor = UIColor.black
        } else {
            // Fallback on earlier versions
        }
       
        
        

        
        
    }
    
//    func updateBadgeNumberonTab() {
//        
//    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
       // SelectedItems.removeAll()
        //numberofItems.removeAll()
     //   let navigationtitle : String = (selectedGroup.value(forKey: "menu_title") as? String)!
      //  self.title = navigationtitle
        super.viewWillAppear(false)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
      
        let SharedInstance1 = CartManager.sharedInstance
        let numberOfItem = SharedInstance1.numberofItemsinCartManager(Change: 0)
        
        tabBarController?.tabBar.items![1].badgeValue =  "\(numberOfItem)"
        if #available(iOS 10.0, *) {
            tabBarController?.tabBar.items![1].badgeColor = UIColor.black
        } else {
            // Fallback on earlier versions
        }
        
        
        let HEADERS: HTTPHeaders = [
            "Token": "d75542712c868c1690110db641ba01a",
            "Accept": "application/json",
            "Merchantname" : "admin",
            "Merchantid" : "3",
            "Connection" : "close"
        ]
        let VisitReference : String  = UserDefaults.standard.object(forKey: "VisitReferenceNumber") as! String
        var UserID = "N"
        if (UserDefaults.standard.dictionary(forKey: "LoggedInUser")) != nil {
            let userDict : NSDictionary = UserDefaults.standard.dictionary(forKey: "LoggedInUser")! as NSDictionary
            UserID = userDict.value(forKey: "enduser_id") as! String
        }
        else {
            UserID = "N"
            
        }

        
        
        
        let MenuID : String = selectedGroup.value(forKey: "menu_id") as! String
        let parameters = ["menu_id":MenuID ,"visit_ref" : VisitReference, "user_id":UserID]
        
        //create the url with URL
        Alamofire.request(
            URL(string: "https://pay-hub.in/payhub%20api/v1/item_detail.php")!,
            method: .post,
            parameters: parameters,
            headers: HEADERS
            )
            
            
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
                    if (self.itemArray.count) > 0 {
                    let Dict2 = self.itemArray.firstObject as! NSDictionary
                    let VisitReferencefromServer = Dict2.value(forKey: "visit_ref")
                    UserDefaults.standard.set(VisitReferencefromServer, forKey: "VisitReferenceNumber")
                    UserDefaults.standard.synchronize()
                    SVProgressHUD.dismiss()
                    }
                    else {
                    self.CollectionViewList.isHidden = true
                        
                        let alert = UIAlertController(title: "No Items in this Category", message: "Please go back and check in other categories", preferredStyle: UIAlertControllerStyle.alert)
                        
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                    }
                }
           
                else {
                    self.viewWillAppear(false)
                    
                }
        }
        
        
        
        
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenheight = screenSize.height
        let Cwidth : CGFloat  = screenWidth-30
        let Cheight : CGFloat = screenheight/5
        
        
        return CGSize(width: Cwidth, height: Cheight)
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
        let itemquantity = dict?.value(forKey: "item_quantity") as! String
        cell.itemGMStepper.value = Double(itemquantity)!
        numberofItems.append(Int(itemquantity)!)
//        cell.itemGMStepper.value = Double(self.numberofItems[indexPath.row])
//        cell.itemGMStepper.addTarget(self, action: #selector(valueChanged(_:)), for: UIControlEvents.valueChanged)
        cell.itemGMStepper.labelFont = UIFont(name: "Helvetica", size: 16)!
        cell.itemGMStepper.buttonsFont = UIFont(name: "Helvetica", size: 16)!
        let pricestring = String(format: " ₹ %@", (dict?.value(forKey: "item_price") as? String)!)
        cell.priceLabel.text = pricestring
//        let topColor = UIColor.clear
//        let bottomColor = UIColor.black
//        
//        
//        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
//        
//        let gradientLoactions: [Float] = [0.7, 1.0]
//        
//        
//        let gradientLayer: CAGradientLayer = CAGradientLayer()
//        
//        gradientLayer.colors = gradientColors
//        
//        gradientLayer.locations = gradientLoactions as [NSNumber]
//        
//        
//        gradientLayer.frame = cell.itemImageView.frame
//        
//        
//        cell.itemImageView.layer.insertSublayer(gradientLayer, at: 0)
        
        return cell
        
    }
    
    
    
    
    func ItemUpdateonServer(PlusorMinus : String) {
        let currentDate : String  = getCurrentDate()
        
        let MerchantID  = "3"
        var UserID = "N"
        if (UserDefaults.standard.dictionary(forKey: "LoggedInUser")) != nil {
            let userDict : NSDictionary = UserDefaults.standard.dictionary(forKey: "LoggedInUser")! as NSDictionary
            UserID = userDict.value(forKey: "enduser_id") as! String
        }
        else {
            UserID = "N"
            
        }
        
        let VisitReference : String = UserDefaults.standard.value(forKey: "VisitReferenceNumber") as! String
        let parameters2 = ["merchant_id": MerchantID , "date" : currentDate, "type" : PlusorMinus, "id": ItemIDofSelected, "visit_ref" : VisitReference, "user_id":UserID] as [String : Any]
        
        let HEADERS: HTTPHeaders = [
            "Token": "d75542712c868c1690110db641ba01a",
            "Accept": "application/json",
            "user_name" : "admin",
            "user_id" : "3"
        ]
        
        Alamofire.request( URL(string: "https://pay-hub.in/payhub%20api/v1/add_to_cart.php")!, method: .post, parameters: parameters2, headers: HEADERS )
            
            
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    print("Response from Updateitems APi is \(dict)")
                    }
                
        }
        

        
       
        }
        
    
    
    func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentDate = formatter.string(from: date)
        return currentDate
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        SVProgressHUD.dismiss()
        numberofItems.removeAll()
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        let SharedInstance = CartManager.sharedInstance
//        SharedInstance.addproduct(product: SelectedItems)
//        
//    }
    

}
