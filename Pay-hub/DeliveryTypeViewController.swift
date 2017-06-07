//
//  DeliveryTypeViewController.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 22/05/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import DLRadioButton
import DropDown
import Alamofire

class DeliveryTypeViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var deliverytimeView: UIView!
    @IBOutlet weak var DeliveryButton: DLRadioButton!
    @IBOutlet weak var PickUpButton: DLRadioButton!
    @IBOutlet weak var deliverytime: DLRadioButton!
    @IBOutlet weak var laterButton: DLRadioButton!
   // @IBOutlet weak var pickupbutton: DLRadioButton!
    @IBOutlet weak var timetextfield: UITextField!
    let dropDown = DropDown()
   
    
  //  @IBOutlet weak var timetextfield: UITextField!
    
   
    
  //  @IBOutlet weak var pickUpButton: DLRadioButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.DeliveryButton.isMultipleSelectionEnabled = true
      //  self.pickUpButton.isMultipleSelectionEnabled = true
        let backButton1 = UIBarButtonItem.init(image: UIImage.init(named: "BackButton"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(backAction(_:)))
        
        
        
        self.navigationItem.leftBarButtonItem = backButton1
        
        
        DeliveryButton.addTarget(self, action: #selector(changeButtonState), for: UIControlEvents.touchUpInside)
        PickUpButton.addTarget(self, action: #selector(changeButtonState), for: UIControlEvents.touchUpInside)
        
        
        deliverytime.addTarget(self, action: #selector(Changedeliverytimebutton), for: UIControlEvents.touchUpInside)
        laterButton.addTarget(self, action: #selector(Changedeliverytimebutton), for: UIControlEvents.touchUpInside)
        deliverytimeView.isHidden = true
     //   laterButton.isHidden = true
    //    pickupbutton.addTarget(self, action: #selector(changeButtonState2), for: UIControlEvents.touchUpInside)
      //  DeliveryButton.otherButtons = [pickUpButton]
      //  pickUpButton.otherButtons = [DeliveryButton]
        timetextfield.delegate = self
        timetextfield.isHidden = true
        
        
        
        // The view to which the drop down will appear on
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(true)
       //https://pay-hub.in/payhub%20api/v1/get_order_type.php
        
        let userdict : NSDictionary = UserDefaults.standard.dictionary(forKey: "LoggedInUser")! as NSDictionary
        
        let MerchantID  = "3"
        let MerchantUsername = "admin"
        
        
        let parameters2 = ["merchant_username": MerchantUsername, "merchant_id": MerchantID ] 
        
        let HEADERS: HTTPHeaders = [
            "Token": "d75542712c868c1690110db641ba01a",
            "Accept": "application/json",
            "user_name" : "admin",
            "user_id" : "3"
        ]
        
        Alamofire.request( URL(string: "https://pay-hub.in/payhub%20api/v1/get_order_type.php")!, method: .post, parameters: parameters2, headers: HEADERS )
            
            
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    print(dict)
                    
                    
//                    if dict.value(forKeyPath:"Response.data.saved_address") is NSNull
//                    {
//                        print("No Added Address")
//                    }
//                    else {
//                       
//                        
//                    }
                    
                    
                    
                }
                
        }
        

        
        
        
//        dropDown.anchorView = self.pickertestview // UIView or UIBarButtonItem
//        
//        // The list of items to display. Can be changed dynamically
//        dropDown.dataSource = ["Car", "Motorcycle", "Truck"]
//        dropDown.show()
//        dropDown.direction = .any
//        dropDown.selectionAction = {
//            [unowned self] (index: Int, item: String) in
//            print("Selected item: \(item) at index: \(index)")
//            
//            self.view.addSubview(self.pickertestview)
//            self.dropDown.hide()
//        }
//
    }
    func changeButtonState() {
        
        
        deliverytimeView.isHidden = false
      //  laterButton.isHidden = false
        let str = DeliveryButton.selected()?.currentTitle
        print("Current Title is \(String(describing: str))")
        
        
    //  print(String(format: "%@ Delivery button is selected.\n", DeliveryButton.selected()!.currentTitle!))

    }
//    func changeButtonState2() {
//        
//        pickupbutton.deselectOtherButtons()
//        deliverytime.isHidden = false
//        laterButton.isHidden = false
//        print(String(format: "%@ is selected.\n", pickupbutton.selected()!.titleLabel!.text!))
//        
//        
//    }
    func Changedeliverytimebutton() {
       
        print(String(format: "%@ Delivery time is selected.\n", deliverytime.selected()!.currentTitle!))
        let str = deliverytime.selected()!.currentTitle!
        if str == "As soon as possible" {
            timetextfield.isHidden = true
        }
        else {
            timetextfield.isHidden = false
        }
        
        
    }
    
//    func Changedeliverytimebutton2() {
//        laterButton.deselectOtherButtons()
//        print(String(format: "%@ is selected.\n", laterButton.selected()!.titleLabel!.text!))
//        timetextfield.isHidden = false
//        textFieldDidBeginEditing(timetextfield)
//    }
   

   
    
    func datePickerChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        timetextfield.text = formatter.string(from: sender.date)
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let datePicker = UIDatePicker()
        textField.inputView = datePicker
        datePicker.minimumDate = Date()
        datePicker.minuteInterval = 30
       
        datePicker.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)

        
        print("This Worked")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        timetextfield.resignFirstResponder()
        return true
    }
    
    // MARK: Helper Methods
    func closekeyboard() {
        self.view.endEditing(true)
    }
    
    // MARK: Touch Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closekeyboard()
    }
    
    @IBAction func proceedButton(_ sender: UIButton) {
        let str = DeliveryButton.selected()?.currentTitle
        print("Current Title of delivery is \(String(describing: str))")
        let str2 = deliverytime.selected()?.currentTitle
        print("Current Title of time is \(String(describing: str2))")
        if str == "Delivery" {
           self.performSegue(withIdentifier: "chooseDeliveryAddress", sender: self)
        }
        if str == "Pick Up" {
            self.performSegue(withIdentifier: "pickUp", sender: self)
        }
        
        
        
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Cancel Checkout process", message: "Are you sure to go back ?", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
        let button2 = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: cancel)
        alert.addAction(button2)
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    

func cancel(action:UIAlertAction) {
    let presentingViewController = self.presentingViewController
    self.dismiss(animated: false, completion: {
        presentingViewController!.dismiss(animated: false, completion: {})
    })

    
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
