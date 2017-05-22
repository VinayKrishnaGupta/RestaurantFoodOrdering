//
//  DeliveryTypeViewController.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 22/05/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import DLRadioButton

class DeliveryTypeViewController: UIViewController {
    @IBOutlet weak var DeliveryButton: DLRadioButton!
    @IBOutlet weak var deliverytime: DLRadioButton!
    @IBOutlet weak var laterButton: DLRadioButton!
    @IBOutlet weak var pickupbutton: DLRadioButton!
    
  //  @IBOutlet weak var pickUpButton: DLRadioButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.DeliveryButton.isMultipleSelectionEnabled = false
      //  self.pickUpButton.isMultipleSelectionEnabled = true
        DeliveryButton.addTarget(self, action: #selector(changeButtonState), for: UIControlEvents.touchUpInside)
        
        deliverytime.addTarget(self, action: #selector(Changedeliverytimebutton), for: UIControlEvents.touchUpInside)
        laterButton.addTarget(self, action: #selector(Changedeliverytimebutton2), for: UIControlEvents.touchUpInside)
        deliverytime.isHidden = true
        laterButton.isHidden = true
        pickupbutton.addTarget(self, action: #selector(changeButtonState2), for: UIControlEvents.touchUpInside)
      //  DeliveryButton.otherButtons = [pickUpButton]
      //  pickUpButton.otherButtons = [DeliveryButton]

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(true)
    }
    func changeButtonState() {
        
        DeliveryButton.deselectOtherButtons()
        deliverytime.isHidden = false
        laterButton.isHidden = false
      print(String(format: "%@ is selected.\n", DeliveryButton.selected()!.titleLabel!.text!))

    }
    func changeButtonState2() {
        
        pickupbutton.deselectOtherButtons()
        deliverytime.isHidden = false
        laterButton.isHidden = false
        print(String(format: "%@ is selected.\n", pickupbutton.selected()!.titleLabel!.text!))
        
        
    }
    func Changedeliverytimebutton() {
        deliverytime.deselectOtherButtons()
        print(String(format: "%@ is selected.\n", deliverytime.selected()!.titleLabel!.text!))
    }
    
    func Changedeliverytimebutton2() {
        laterButton.deselectOtherButtons()
        print(String(format: "%@ is selected.\n", laterButton.selected()!.titleLabel!.text!))
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
