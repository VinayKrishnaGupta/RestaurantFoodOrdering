//
//  EditCartViewController.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 02/06/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class EditCartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var editCartTableView: UITableView!
    var addedproducts : NSArray = []
    var ItemIDofSelected : String = ""
    var badgenumber : Int = 0
    var FinalBadgeNumber : Int = 0
    var SavedIndexpath: Int? = nil
    var numberofItems : Array<Int>   = []

    override func viewDidLoad() {
        
        super.viewDidLoad()
        editCartTableView.delegate = self
        editCartTableView.dataSource = self
       // self.navigationItem.setHidesBackButton(true, animated:true);
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SVProgressHUD.show()
        super.viewWillAppear(false)
        
        let MerchantID  = "3"
        let MerchantUserName = "admin"
        var UserID = "N"
        
        if (UserDefaults.standard.dictionary(forKey: "LoggedInUser")) != nil {
            let userDict : NSDictionary = UserDefaults.standard.dictionary(forKey: "LoggedInUser")! as NSDictionary
            UserID = userDict.value(forKey: "enduser_id") as! String
        }
        else {
            UserID = "N"
            
        }
        
        let VisitReference : String = UserDefaults.standard.value(forKey: "VisitReferenceNumber") as! String
        let parameters2 = ["merchant_id": MerchantID , "merchant_username" : MerchantUserName, "visit_ref" : VisitReference, "user_id":UserID] as [String : Any]
        
        let HEADERS: HTTPHeaders = [
            "Token": "d75542712c868c1690110db641ba01a",
            "Accept": "application/json",
            "Merchantname" : "admin",
            "Merchantid" : "3"
        ]
        
        Alamofire.request( URL(string: "https://pay-hub.in/payhub%20api/v1/get_cart.php")!, method: .post, parameters: parameters2, headers: HEADERS )
            
            
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    SVProgressHUD.dismiss()
                    let dict = json as! NSDictionary
                    print("Response from getCart is \(dict)")
                    if dict.value(forKeyPath: "Response.data.cart.item") != nil {
                        
                        self.addedproducts = dict.value(forKeyPath: "Response.data.cart.item") as! NSArray
                        SVProgressHUD.dismiss()
                        self.editCartTableView.reloadData()
                        
                       
                        
                    }
                    else {
                        print("No Item in cart")
                        
                        
                    }
                }
                
        }
        
        
        
        

        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addedproducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = editCartTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EditCartTableViewCell
        let dict : NSDictionary = addedproducts.object(at: indexPath.row) as! NSDictionary
        let itemName : String = dict.value(forKey: "item_name") as! String
        let itemquantity = dict.value(forKey: "item_quantity") as! String
        
        cell.itemNameLabel.text = itemName
        cell.itemCountStepper.value = Double(itemquantity)!
        cell.itemCountStepper.labelFont = UIFont(name: "Helvetica", size: 16)!
        cell.itemCountStepper.buttonsFont = UIFont(name: "Helvetica", size: 16)!
        numberofItems.append(Int(itemquantity)!)
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    @IBAction func itemStepperValuechanged(_ sender: Any) {
        
        print("Value changed )")
        let pos = (sender as AnyObject).convert(CGPoint.zero, to: editCartTableView)
        let indexPath = editCartTableView.indexPathForRow(at: pos)!
        let dict = addedproducts[indexPath.row] as? NSDictionary
        ItemIDofSelected = (dict?.value(forKey: "item_id") as? String)!
        
        
        guard let cell: EditCartTableViewCell = (editCartTableView.cellForRow(at: indexPath)) as? (EditCartTableViewCell)
            else
        {
            print("Can't deque cells")
            return
        }
        print("value of \(indexPath.row) row changed by \(cell.itemCountStepper.value))")
        print("value of \(indexPath.row) row changed by step value \(cell.itemCountStepper.stepValue))")
        
        
        
        if SavedIndexpath == indexPath.row
        {
            if numberofItems[indexPath.row] >=  Int(cell.itemCountStepper.value)  {
                
                FinalBadgeNumber = FinalBadgeNumber - Int(cell.itemCountStepper.stepValue)
                badgenumber = badgenumber - Int(cell.itemCountStepper.stepValue)
                // let dict = self.itemArray[indexPath.row]
                self.numberofItems[indexPath.row] = badgenumber
                print("number 1 of items at indexpath is \(numberofItems[indexPath.row])")
                let SharedInstance1 = CartManager.sharedInstance
                SharedInstance1.numberofItemsinCartManager(Change: -1)
                self.ItemUpdateonServer(PlusorMinus: "minus")
                
                // self.SelectedItems.insert(dict, at: indexPath.row)
            }
            else {
                
                FinalBadgeNumber = FinalBadgeNumber + Int(cell.itemCountStepper.stepValue)
                badgenumber = badgenumber + Int(cell.itemCountStepper.stepValue)
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
            
            if numberofItems[indexPath.row] >=  Int(cell.itemCountStepper.value)  {
                badgenumber = 0
                FinalBadgeNumber = FinalBadgeNumber - Int(cell.itemCountStepper.stepValue)
                badgenumber = badgenumber - Int(cell.itemCountStepper.stepValue)
                let dict = self.addedproducts[indexPath.row]
                self.numberofItems[indexPath.row] = Int(cell.itemCountStepper.value)
                print("number 3 of items at indexpath is \(numberofItems[indexPath.row])")
                let SharedInstance1 = CartManager.sharedInstance
                SharedInstance1.numberofItemsinCartManager(Change: -1)
                self.ItemUpdateonServer(PlusorMinus: "minus")
            }
            else {
                badgenumber = 0
                FinalBadgeNumber = FinalBadgeNumber + Int(cell.itemCountStepper.stepValue)
                badgenumber = badgenumber + Int(cell.itemCountStepper.stepValue)
                let dict = self.addedproducts[indexPath.row]
                self.numberofItems[indexPath.row] = badgenumber
                print("number 4 of items at indexpath is \(numberofItems[indexPath.row])")
    
                let SharedInstance1 = CartManager.sharedInstance
                SharedInstance1.numberofItemsinCartManager(Change: 1)
                self.ItemUpdateonServer(PlusorMinus: "plus")
                
            }
            
        }
        SavedIndexpath = indexPath.row
        
        
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
    
    
    
    func ItemUpdateonServer(PlusorMinus : String) {
        SVProgressHUD.show()
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
                    SVProgressHUD.dismiss()
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
    
    
    override func viewDidDisappear(_ animated: Bool) {
        numberofItems.removeAll()
        SVProgressHUD.dismiss()
    }
    
    @IBAction func SaveButton(_ sender: UIButton) {
        SVProgressHUD.show()
        self.navigationController?.popViewController(animated: false)
        
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
