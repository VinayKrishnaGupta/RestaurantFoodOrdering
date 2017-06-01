//
//  ReviewOrderViewController.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 24/05/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import Alamofire

class ReviewOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var addedproducts : NSArray = []
    var TaxesfromAPI : NSArray = []
    var subtotalpricefromAPI = 0
    var totalPricefromAPI = 0
    var OrderNumber : String = ""
    public var selectedAddress : NSDictionary = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
         let userdict : NSDictionary = UserDefaults.standard.dictionary(forKey: "LoggedInUser")! as NSDictionary
        let userID = userdict.value(forKey: "enduser_id")
        let MerchantID  = "3"
        let MerchantUserName = "admin"
        let VisitReference : String = UserDefaults.standard.value(forKey: "VisitReferenceNumber") as! String
        let parameters2 = ["merchant_id": MerchantID , "merchant_username" : MerchantUserName, "visit_ref" : VisitReference, "user_id":userID] as! [String : String]
        
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
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
            cell2.numberlabel.text = (dict.value(forKey: "item_quantity") as? String)! + "x"
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
            
        if indexPath.section == 5 {
            let cell6 = tableView.dequeueReusableCell(withIdentifier: "DeliveryAddress", for: indexPath)
            let address : String = selectedAddress.value(forKey: "address") as! String
            cell6.textLabel?.text = "Delivery Address: " + address
            
            return cell6
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

    
    
    

    @IBAction func createOrderButton(_ sender: UIButton) {
        self.createorder()
        
    }
    
    func createorder() {
        
        let userdict : NSDictionary = UserDefaults.standard.dictionary(forKey: "LoggedInUser")! as NSDictionary
        let currentDate : String  = getCurrentDate()
        let MerchantID  = "3"
        let MerchantUsername = "admin"
        // let VisitReference : String = UserDefaults.standard.value(forKey: "VisitReferenceNumber") as! String
        
        let userID = userdict.value(forKey: "enduser_id")
        let MobileNumber = userdict.value(forKey: "enduser_mobile")
        
        let parameters2 = ["merchant_username": MerchantUsername, "merchant_id": MerchantID , "enduser_id" : userID, "enduser_mobile": MobileNumber, "type" : "Delivery", "type_sub": "asap", "ddate":"2017-05-25", "dtime":"3#10", "date": currentDate, "address": selectedAddress.value(forKey: "id")] as [String:AnyObject]
        
        let HEADERS: HTTPHeaders = [
            "Token": "d75542712c868c1690110db641ba01a",
            "Accept": "application/json",
            "user_name" : "admin",
            "user_id" : "3"
        ]
        
        Alamofire.request( URL(string: "https://pay-hub.in/payhub%20api/v1/create_order.php")!, method: .post, parameters: parameters2, headers: HEADERS )
            
            
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    self.OrderNumber = dict.value(forKeyPath: "Response.data.order") as! String
                    print("Response from Create Order is \(dict)")
                    
                    self.performSegue(withIdentifier: "proceedtopayment", sender: self)
                   // self.processorder()
                    
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
    
    
    func processorder() {
        let userdict : NSDictionary = UserDefaults.standard.dictionary(forKey: "LoggedInUser")! as NSDictionary
        let currentDate : String  = getCurrentDate()
        let MerchantID  = "3"
        let MerchantUsername = "admin"
        // let VisitReference : String = UserDefaults.standard.value(forKey: "VisitReferenceNumber") as! String
        
        let userID = userdict.value(forKey: "enduser_id")
        
        let parameters2 = ["merchant_username": MerchantUsername, "merchant_id": MerchantID , "enduser_id" : userID, "order": OrderNumber, "address": selectedAddress.value(forKey: "id") , "date": currentDate, "notified":""] as [String:AnyObject]
        
        let HEADERS: HTTPHeaders = [
            "Token": "d75542712c868c1690110db641ba01a",
            "Accept": "application/json",
            "user_name" : "admin",
            "user_id" : "3"
        ]
        
        Alamofire.request( URL(string: "https://pay-hub.in/payhub%20api/v1/create_order.php")!, method: .post, parameters: parameters2, headers: HEADERS )
            
            
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    print("Response from Create Order is \(dict)")
                    
                }
                
        }
        

        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "proceedtopayment" {
            if let nextViewController = segue.destination as? ThankYouPageViewController{
                nextViewController.ordernumber = self.OrderNumber
                
            }
            
        }    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
