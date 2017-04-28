//
//  MyCartViewController.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 24/04/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit

class MyCartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let SharedInstance = CartManager.sharedInstance
        let itemsfromSingleton : Array = SharedInstance.MyCartItems
        
        print("Seleced Item array from Singleton is \(itemsfromSingleton.count)")
        
        

        // Do any additional setup after loading the view.
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(self.getselectedItems(_:)), name: NSNotification.Name(rawValue: "notificationName"), object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
    //    NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NumberofaddedItems"), object: nil)
        

    }
    func getselectedItems(_ notification: NSNotification) {
        
        
        
        print("Notification Recieved")
        let dict : NSDictionary = (notification.userInfo?["SelectedItem"] as? NSDictionary)!
        print("Notification selected Dict is \(dict)")
        
//        if (notification.userInfo?["image"] as? UIImage) != nil {
//            print("Notification 2 Recieved")
//        }
//        if let image : NSDictionary = notification.userInfo?["image"] as? NSDictionary {
//            // do something with your image
//        }
    }
    
    
    func methodOfReceivedNotification(notification: NSNotification){
        print("Notification received")
        if let addeditem = notification.userInfo?["SelectedItem"] as? NSDictionary {
            print("Selected Dict in Notification is \(addeditem)")
        }
        //let addeditems  = notification.object as? Array<Any>
       // print("Number of Items is Notification is \(String(describing: addeditems?.count))" as Any)
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
