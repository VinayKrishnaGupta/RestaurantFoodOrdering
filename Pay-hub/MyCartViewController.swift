    //
//  MyCartViewController.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 24/04/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import Alamofire

class MyCartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var addedproducts : NSArray = []
    var TaxesfromAPI : NSArray = []
    var subtotalpricefromAPI = 0
    var totalPricefromAPI = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
      //  print("Seleced Item array from Singleton is \(addedproducts)")
        
        
    //    self.tableView.reloadData()
        

        // Do any additional setup after loading the view.
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(self.getselectedItems(_:)), name: NSNotification.Name(rawValue: "notificationName"), object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
        
        let MerchantID  = "3"
        let MerchantUserName = "admin"
        let UserID = "N"
        let VisitReference : String = UserDefaults.standard.value(forKey: "VisitReferenceNumber") as! String
        let parameters2 = ["merchant_id": MerchantID , "merchant_username" : MerchantUserName, "visit_ref" : VisitReference, "user_id":UserID] as [String : Any]
        
        let HEADERS: HTTPHeaders = [
            "Token": "d75542712c868c1690110db641ba01a",
            "Accept": "application/json",
            "user_name" : "admin",
            "user_id" : "3"
        ]
        
        Alamofire.request( URL(string: "https://pay-hub.in/payhub%20api/v1/get_cart.php")!, method: .post, parameters: parameters2, headers: HEADERS )
            
            
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    print("Response from getCart is \(dict)")
                    self.addedproducts = dict.value(forKeyPath: "Response.data.cart.item") as! NSArray
                   self.TaxesfromAPI = dict.value(forKeyPath: "Response.data.cart.tax") as! NSArray
                    self.subtotalpricefromAPI = dict.value(forKeyPath: "Response.data.cart.subtotal") as! Int
                    self.totalPricefromAPI = dict.value(forKeyPath: "Response.data.cart.total_price") as! Int
                    self.tableView.reloadData()
                }
                
        }
        
        
        
        

        
        
    }
    func getselectedItems(_ notification: NSNotification) {
        
        
        
        print("Notification Recieved")
        let dict : NSDictionary = (notification.userInfo?["SelectedItem"] as? NSDictionary)!
        print("Notification selected Dict is \(dict)")
        
        
        let SharedInstance = CartManager.sharedInstance
        SharedInstance.addproduct(product: dict)
//        if (notification.userInfo?["image"] as? UIImage) != nil {
//            print("Notification 2 Recieved")
//        }
//        if let image : NSDictionary = notification.userInfo?["image"] as? NSDictionary {
//            // do something with your image
//        }
    }
    
    
    func methodOfReceivedNotification(notification: NSNotification){
        print("Notification received")
        if let addeditem = notification.userInfo?["SelectedItem"] as? NSDictionary {
            print("Selected Dict in Notification is \(addeditem)")
        }
        //let addeditems  = notification.object as? Array<Any>
       // print("Number of Items is Notification is \(String(describing: addeditems?.count))" as Any)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5;
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 1 {
            return addedproducts.count
        }
        if section == 3 {
            return TaxesfromAPI.count
        }

        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
       
        if indexPath.section == 0 {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "CartTitle", for: indexPath) as! MyCartTitleCell
            return cell1
        }
            
        if indexPath.section == 1 {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "CartItems", for: indexPath) as! MyCartCellTableViewCell
            print("added products indexpath \(addedproducts[indexPath.row])")
            let dict : NSDictionary  = self.addedproducts[indexPath.row] as! NSDictionary
            cell2.numberlabel.text = (dict.value(forKey: "item_quantity") as? String)!
            let TotalPricefromAPI : AnyObject = dict.value(forKey: "item_total_price") as AnyObject
            let TotalPrice : String = String(describing: TotalPricefromAPI)
            cell2.priceLabel.text = TotalPrice
            cell2.titleLabel.text = (dict.value(forKey: "item_name") as! String)
            
            
            return cell2
        }
          
        if indexPath.section == 2 {
            let cell3 = tableView.dequeueReusableCell(withIdentifier: "Subtotal", for: indexPath) as! MyCartCellTableViewCell
            cell3.textLabel?.text = "SubTotal"
            cell3.detailTextLabel?.text = String(describing: subtotalpricefromAPI)
            
            
            return cell3
        }
        if indexPath.section == 3 {
            let cell4 = tableView.dequeueReusableCell(withIdentifier: "TaxCell", for: indexPath) as! MyCartCellTableViewCell
            let dict4 : NSDictionary = self.TaxesfromAPI[indexPath.row] as! NSDictionary
            cell4.textLabel?.text = (dict4.value(forKeyPath: "tax_name") as! String)
            let taxpricefromAPI : AnyObject = dict4.value(forKeyPath: "tax_price") as AnyObject
            let taxprice : String = String(describing: taxpricefromAPI)
            cell4.detailTextLabel?.text =  taxprice
            
            
            return cell4
        }
            
        
        else {
            let cell5 = tableView.dequeueReusableCell(withIdentifier: "TotalPrice", for: indexPath)
            if indexPath.section == 4 {
                cell5.textLabel?.text = "Total Price"
                cell5.detailTextLabel?.text = String(describing: totalPricefromAPI)

            }
            return cell5
        }
       
    }
    
    @IBAction func proceedToCheckoutButton(_ sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Auth", bundle: nil)
        let vc : SignupoptionsViewController = storyboard.instantiateViewController(withIdentifier: "authoptionsVC") as! SignupoptionsViewController
       // vc.teststring = "hello"
        
      //  let navigationController = UINavigationController(rootViewController: vc)
        
       self.navigationController?.pushViewController(vc, animated: true)
        
        
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
