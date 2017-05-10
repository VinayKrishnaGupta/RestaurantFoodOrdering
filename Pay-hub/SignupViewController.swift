    //
//  SignupViewController.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 09/05/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import Alamofire

class SignupViewController: UIViewController {
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var countryCodeTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func createAccountButton(_ sender: UIButton) {
        self.perform(#selector(signup), with: self)
    }
    
    @IBAction func LoginButton(_ sender: UIButton) {
    }

    @IBAction func ContinueAsguestButtpn(_ sender: UIButton) {
    }
    
    func signup() {
        
        
     print("Signup pressed")
        let currentDate : String  = getCurrentDate()
        
        let MerchantID  = "3"
        let MerchantUsername = "admin"
       // let VisitReference : String = UserDefaults.standard.value(forKey: "VisitReferenceNumber") as! String
        let Firstname = self.firstNameTextfield.text
        let LastName = self.lastNameTextField.text
        let CountryCode = self.countryCodeTextField.text
        let MobileNumber = self.mobileTextField.text
        let Email = self.emailTextField.text
        
        let parameters2 = ["merchant_username": MerchantUsername, "merchant_id": MerchantID , "date" : currentDate, "fname" : Firstname, "lname": LastName, "guest" : "N", "code":CountryCode, "mobile" : MobileNumber, "email" : Email] as! [String:String]
        
        let HEADERS: HTTPHeaders = [
            "Token": "d75542712c868c1690110db641ba01a",
            "Accept": "application/json",
            "user_name" : "admin",
            "user_id" : "3"
        ]
        
        Alamofire.request( URL(string: "https://pay-hub.in/payhub%20api/v1/signup.php")!, method: .post, parameters: parameters2, headers: HEADERS )
            
            
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    print("Response from Signup \(dict)")
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
