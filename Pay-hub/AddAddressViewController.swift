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
    let dropdown = DropDown()

    override func viewDidLoad() {
        super.viewDidLoad()
        address2.delegate = self
        dropdown.anchorView = address2
        
                dropdown.dataSource = ["Sector 14", "Sector 31", "Sector 38","Sector 39", "Phase 4", "Phase 5", "Sector 31", "Sector 38","Sector 39", "Phase 4", "Phase 5", "Sector 31", "Sector 38","Sector 39", "Phase 4", "Phase 5", "Sector 31", "Sector 38","Sector 39", "Phase 4", "Phase 5"]
                
                dropdown.direction = .any
//                dropdown.selectionAction = {
//                    [unowned self] (index: Int, item: String) in
//                    print("Selected item: \(item) at index: \(index)")
//        }
        dropdown.selectionAction = {
            [unowned self] (index: Int, item: String) in
            self.address2.text = item
        }
        // Do any additional setup after loading the view.
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        dropdown.show()
        return false
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
       
        

        
        dropdown.hide()
        return true
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
