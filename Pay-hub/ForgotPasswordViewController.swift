//
//  ForgotPasswordViewController.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 29/05/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import Alamofire

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    var MobileNumber : String = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SigninViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ProceedButton(_ sender: UIButton) {
        self.perform(#selector(forgotpassword), with: self)
        
    }
    
    func forgotpassword() {
        
        let currentDate : String  = getCurrentDate()
        
        let MerchantID  = "3"
        let MerchantUsername = "admin"
        // let VisitReference : String = UserDefaults.standard.value(forKey: "VisitReferenceNumber") as! String
        let username = self.emailTextField.text

        
        let parameters2 = ["merchant_username": MerchantUsername, "merchant_id": MerchantID , "date" : currentDate, "email" : username] as! [String:String]
        
        let HEADERS: HTTPHeaders = [
            "Token": "d75542712c868c1690110db641ba01a",
            "Accept": "application/json",
            "user_name" : "admin",
            "user_id" : "3"
        ]
        
        Alamofire.request( URL(string: "https://pay-hub.in/payhub%20api/v1/forgot.php")!, method: .post, parameters: parameters2, headers: HEADERS )
            
            
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    let type : String = dict.value(forKeyPath: "Response.data.type") as! String
                    let message : String = dict.value(forKeyPath: "Response.data.message") as! String
                    if type == "success" {
                        let mobilenumber = dict.value(forKeyPath: "Response.data.mobile") as! String
                        let arrstr = mobilenumber.components(separatedBy: "-")
                        self.MobileNumber = arrstr[1]
                        self.performSegue(withIdentifier: "OTPverifyfromForgotPassword", sender: self)
                        print(message)

                        
                    }
                    else {
                        let alert = UIAlertController(title: "Try Again", message: message, preferredStyle: UIAlertControllerStyle.alert)
                        
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                    }
                    
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
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OTPverifyfromForgotPassword"  {
            if let otpVC = segue.destination as? VerifyOTPViewController {
                otpVC.mobilenumberfromsignup = MobileNumber
                otpVC.guestType = "Y"
                otpVC.type = "login"
                
                
            }
        }
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
