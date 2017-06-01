//
//  GetAddressViewController.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 23/05/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import Alamofire

class GetAddressViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableVIew: UITableView!
    var SavedAddress : NSArray = []
    var AddressSelected : NSDictionary = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableVIew.dataSource = self
        tableVIew.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getlistofAddress()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SavedAddress.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVIew.dequeueReusableCell(withIdentifier: "getAddressTableViewCell", for: indexPath) as! getAddressTableViewCell
        let dict : NSDictionary = SavedAddress.object(at: indexPath.section) as! NSDictionary
        cell.address1label.text = (dict.value(forKey: "name") as! String)
        cell.address2label.text = (dict.value(forKey: "address") as! String)
        cell.address3label.text = (dict.value(forKey: "Phone") as! String)
        
        
        return cell
    }
    
    func getlistofAddress() {
    
        
        let userdict : NSDictionary = UserDefaults.standard.dictionary(forKey: "LoggedInUser")! as NSDictionary

        let MerchantID  = "3"
        let MerchantUsername = "admin"
        // let VisitReference : String = UserDefaults.standard.value(forKey: "VisitReferenceNumber") as! String

        let username = userdict.value(forKey: "enduser_name")
        let userID = userdict.value(forKey: "enduser_id")
        let MobileNumber = userdict.value(forKey: "enduser_mobile")
        
        let parameters2 = ["merchant_username": MerchantUsername, "merchant_id": MerchantID , "enduser_id" : userID , "enduser_name":username, "enduser_mobile": MobileNumber] as! [String:String]
        
        let HEADERS: HTTPHeaders = [
            "Token": "d75542712c868c1690110db641ba01a",
            "Accept": "application/json",
            "user_name" : "admin",
            "user_id" : "3"
        ]
        
        Alamofire.request( URL(string: "https://pay-hub.in/payhub%20api/v1/get_address.php")!, method: .post, parameters: parameters2, headers: HEADERS )
            
            
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    print(dict)
                    
                   if dict.value(forKeyPath:"Response.data.saved_address") is NSNull
                    {
                        print("No Added Address")
                                            }
                    else {
                    self.SavedAddress = dict.value(forKeyPath:"Response.data.saved_address") as! NSArray
                    self.tableVIew.reloadData()

                    }
                    
                    
                    
                }
                
        }

        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableVIew.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
        self.AddressSelected = SavedAddress.object(at: indexPath.section) as! NSDictionary
        print("Selected Address is \(AddressSelected)")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableVIew.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func addAddressButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "addAddress", sender: self)
        
    }

    @IBAction func reviewOrderButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "revieworder", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "revieworder" {
            if let nextViewController = segue.destination as? ReviewOrderViewController{
                //  let destinationViewController = nextViewController.viewControllers?[0] as! MenuItemListViewController
                nextViewController.selectedAddress = AddressSelected
            }
            
        }
    }
    
}
