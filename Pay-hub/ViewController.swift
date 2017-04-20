//
//  ViewController.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 11/04/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate{
    @IBOutlet weak var selectCity: UITextField!
    @IBOutlet weak var selectArea: UITextField!
    @IBOutlet weak var pickerView1: UIPickerView!
    @IBAction func orderNowButton(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "cuisinegroups", sender: self)
        
    }

    var City = ["Delhi", "Noida", "Gurgaon", "Bangalore", "Mumbai"]
    var Area = ["Sector 12" , "Sector 18", "Sector 21", "Sector 32", "Sector 50"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView1.dataSource = self
        pickerView1.delegate = self
        
        self.selectCity.inputView = pickerView1
       
        
        
        
        
        
    }
   
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return City.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
        return City[row]
        }
        if component == 1 {
        return Area[row]
        }
        else {
            return nil
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectCity.text = City[row]
        selectArea.text = Area[row]
        
        
        
        
        
    }
    


}

