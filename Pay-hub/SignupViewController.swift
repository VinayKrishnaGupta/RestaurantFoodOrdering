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
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignupViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func createAccountButton(_ sender: UIButton) {
        if (firstNameTextfield.text?.isEmpty)! || (lastNameTextField.text?.isEmpty)! || (countryCodeTextField.text?.isEmpty)! || (mobileTextField.text?.isEmpty)! || (emailTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! || (repeatPassword.text?.isEmpty)!
        {
            let alert = UIAlertController(title: "All Fields are Mandetory", message: "Please fill all the information then continue", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)        }
        else
        {
            if (passwordTextField.text == repeatPassword.text) {
                self.perform(#selector(signup), with: self)
            }
            else {
                let alert = UIAlertController(title: "Password doesn't match", message: "Password and Confirm password should be same, Please try again", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func LoginButton(_ sender: UIButton) {
        
     self.performSegue(withIdentifier: "loginview", sender: self)
        
    }

    @IBAction func ContinueAsGuest(_ sender: UIButton) {
    self.performSegue(withIdentifier: "continueasguest", sender: self)
        
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
        let password = self.passwordTextField.text
        
        let parameters2 = ["merchant_username": MerchantUsername, "merchant_id": MerchantID , "date" : currentDate, "fname" : Firstname, "lname": LastName, "guest" : "N", "code":CountryCode, "mobile" : MobileNumber, "email" : Email, "pass":password] as! [String:String]
        
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
                    let type : String = dict.value(forKeyPath: "Response.data.type") as! String
                    let message : String = dict.value(forKeyPath: "Response.data.message") as! String
                    if type == "success" {
                        self.performSegue(withIdentifier: "toOTPvcfromsignup", sender: self)
                        print(message)
                    }
                    else {
                        let alert = UIAlertController(title: "Try Again", message: message, preferredStyle: UIAlertControllerStyle.alert)
                        
                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                    }
                    print("Response from Signin \(dict)")
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
        if segue.identifier == "toOTPvcfromsignup"  {
            if let otpVC = segue.destination as? VerifyOTPViewController {
                otpVC.mobilenumberfromsignup = self.mobileTextField.text!
                
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
