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

class DeliveryTypeViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var deliverytimeView: UIView!
    @IBOutlet weak var DeliveryButton: DLRadioButton!
    @IBOutlet weak var deliverytime: DLRadioButton!
 //   @IBOutlet weak var laterButton: DLRadioButton!
   // @IBOutlet weak var pickupbutton: DLRadioButton!
    @IBOutlet weak var timetextfield: UITextField!
    let dropDown = DropDown()
    @IBOutlet weak var pickertestview: UIView!
    
  //  @IBOutlet weak var timetextfield: UITextField!
    
   
    
  //  @IBOutlet weak var pickUpButton: DLRadioButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.DeliveryButton.isMultipleSelectionEnabled = true
      //  self.pickUpButton.isMultipleSelectionEnabled = true
        DeliveryButton.addTarget(self, action: #selector(changeButtonState), for: UIControlEvents.touchUpInside)
        
        deliverytime.addTarget(self, action: #selector(Changedeliverytimebutton), for: UIControlEvents.touchUpInside)
    //    laterButton.addTarget(self, action: #selector(Changedeliverytimebutton2), for: UIControlEvents.touchUpInside)
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
        timetextfield.isHidden = true
    }
    
//    func Changedeliverytimebutton2() {
//        laterButton.deselectOtherButtons()
//        print(String(format: "%@ is selected.\n", laterButton.selected()!.titleLabel!.text!))
//        timetextfield.isHidden = false
//        textFieldDidBeginEditing(timetextfield)
//    }
   

   
    
    func datePickerChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        
        timetextfield.text = formatter.string(from: sender.date)
        
        print("Try this at home")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let datePicker = UIDatePicker()
        textField.inputView = datePicker
        datePicker.minimumDate = Date()
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
