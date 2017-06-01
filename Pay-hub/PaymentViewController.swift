//
//  PaymentViewController.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 25/05/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import DLRadioButton

class PaymentViewController: UIViewController {
    @IBOutlet weak var radioButton: DLRadioButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    

    @IBAction func confirmOrderButton(_ sender: UIButton) {
        let str = radioButton.selected()?.currentTitle
        print("Current Title is \(String(describing: str))")
        self.performSegue(withIdentifier: "ThankYouPage", sender: self)
        
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
