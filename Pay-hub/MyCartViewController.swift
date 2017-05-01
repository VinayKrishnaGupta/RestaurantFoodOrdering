//
//  MyCartViewController.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 24/04/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit

class MyCartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let SharedInstance = CartManager.sharedInstance
       let AddedItems = SharedInstance.getCartItems()
        
        print("Seleced Item array from Singleton is \(AddedItems)")
        
        

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
        
        
        let SharedInstance = CartManager.sharedInstance
        SharedInstance.addproduct(product: dict)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3;
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 1 {
            return 3
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
       
        if indexPath.section == 0 {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "CartTitle", for: indexPath) as! MyCartTitleCell
            return cell1
        }
            
        if indexPath.section == 1 {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "CartItems", for: indexPath) as! MyCartCellTableViewCell
            return cell2
        }
        
        else {
            let cell3 = tableView.dequeueReusableCell(withIdentifier: "TaxCell", for: indexPath) 
            return cell3
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
