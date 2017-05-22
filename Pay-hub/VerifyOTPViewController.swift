//
//  VerifyOTPViewController.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 19/05/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import Alamofire

class VerifyOTPViewController: UIViewController {
    public var mobilenumberfromsignup : String = ""
    public var type : String = "active"
    @IBOutlet weak var otpTextField: UITextField!

    @IBAction func verifyOTPButton(_ sender: UIButton) {
        self.VerifyOTPwithServer()
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func VerifyOTPwithServer() {
        
        let currentDate : String  = getCurrentDate()
        
        let MerchantID  = "3"
        let MerchantUsername = "admin"
        // let VisitReference : String = UserDefaults.standard.value(forKey: "VisitReferenceNumber") as! String
        let otptext = self.otpTextField.text
        let mobilenumber = self.mobilenumberfromsignup
        let guesttype : String = "N"
        let VisitReference : String = UserDefaults.standard.value(forKey: "VisitReferenceNumber") as! String
        
        let parameters2 = ["merchant_username": MerchantUsername, "merchant_id": MerchantID , "date" : currentDate, "otp" : otptext, "otp_for": mobilenumber, "guest":guesttype,"visit_ref" : VisitReference, "type": type] as! [String:String]
        
        let HEADERS: HTTPHeaders = [
            "Token": "d75542712c868c1690110db641ba01a",
            "Accept": "application/json",
            "user_name" : "admin",
            "user_id" : "3"
        ]
        
        Alamofire.request( URL(string: "https://pay-hub.in/payhub%20api/v1/opt_verify.php")!, method: .post, parameters: parameters2, headers: HEADERS )
            
            
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    let type : String = dict.value(forKeyPath: "Response.data.type") as! String
                    let message : String = dict.value(forKeyPath: "Response.data.message") as! String
                    if type == "success" {
                        print(message)
                        let storyboard : UIStoryboard = UIStoryboard(name: "Checkout", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "Deliverytype")
                        self.navigationController?.pushViewController(vc, animated: true)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
