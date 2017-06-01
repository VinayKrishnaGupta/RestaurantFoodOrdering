//
//  AddAddressViewController.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 23/05/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import Alamofire
import DropDown

class AddAddressViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var address1: UITextField!
    @IBOutlet weak var address2: UITextField!
    @IBOutlet weak var address3: UITextField!
    var Locations : Any = []
    var cityNames : Any = []
    let dropdown = DropDown()
    let cityDropdown = DropDown()

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddAddressViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        address1.delegate = self
        address2.delegate = self
        address3.delegate = self
        
        dropdown.anchorView = address2
        
                dropdown.dataSource = ["Sector 14", "Sector 31", "Sector 38","Sector 39", "Phase 4", "Phase 5", "Sector 30", "Sector 48","Sector 49", "Phase 2", "Phase 1", "Vasant Kunj", "Sector 82","IMT", "Mehrauli", "Vasant Vihar", "Hauzkhas", "Sector 51","Sector 50", "Golf Course Road", "Sikanderpur"]
                
                dropdown.direction = .any
//                dropdown.selectionAction = {
//                    [unowned self] (index: Int, item: String) in
//                    print("Selected item: \(item) at index: \(index)")
//        }
        dropdown.selectionAction = {
            [unowned self] (index: Int, item: String) in
            self.address2.text = item
        }
        cityDropdown.anchorView = address3
        cityDropdown.dataSource = ["Delhi", "Gurgaon"]
        cityDropdown.direction = .any
        cityDropdown.selectionAction = {
            [unowned self] (index: Int, item: String) in
            self.address3.text = item
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let MerchantID  = "3"
        let MerchantUsername = "admin"
        let parameters = ["merchant_username": MerchantUsername, "merchant_id" : MerchantID]
        
        let HEADERS: HTTPHeaders = [
            "Token": "d75542712c868c1690110db641ba01a",
            "Accept": "application/json",
            "user_name" : "admin",
            "user_id" : "3"
        ]
        
        Alamofire.request( URL(string: "https://pay-hub.in/payhub%20api/v1/location.php")!, method: .post, parameters: parameters, headers: HEADERS )
            
            
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    print(dict)
                    self.Locations = dict.value(forKeyPath: "Response.data.location")!
                   
                    
                }
                
        }
        
        

    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == address2 {
             dropdown.show()
            return false
        }
        if textField == address3 {
            cityDropdown.show()
            return false
        }
        else {
            return true
        }
        
       
        
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
       
        

        if textField == address2 {
            dropdown.hide()
            return false
        }
        if textField == address3 {
            cityDropdown.hide()
            return false
        }
        else {
            return true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addAddress() {
        
        
        let userdict : NSDictionary = UserDefaults.standard.dictionary(forKey: "LoggedInUser")! as NSDictionary
        
        let MerchantID  = "3"
        let MerchantUsername = "admin"
        // let VisitReference : String = UserDefaults.standard.value(forKey: "VisitReferenceNumber") as! String
        
        let userID = userdict.value(forKey: "enduser_id")
        let address1 = self.address1.text
        let address2 = self.address2.text
        let address3 = self.address3.text
        
        let parameters2 = ["merchant_username": MerchantUsername, "merchant_id": MerchantID , "enduser_id" : userID , "add1":address1, "add2": address2, "add3": address3] as! [String:String]
        
        let HEADERS: HTTPHeaders = [
            "Token": "d75542712c868c1690110db641ba01a",
            "Accept": "application/json",
            "user_name" : "admin",
            "user_id" : "3"
        ]
        
        Alamofire.request( URL(string: "https://pay-hub.in/payhub%20api/v1/add_address.php")!, method: .post, parameters: parameters2, headers: HEADERS )
            
            
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    print(dict)
                    
                }
                
        }
        
        

        
        
    }
    

    @IBAction func addAddressButton(_ sender: UIButton) {
        self.addAddress()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
