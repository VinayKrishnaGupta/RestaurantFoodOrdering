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
    var addedproducts : NSArray = []
    let TaxNames = ["VAT(14.5%)", "Service Tax(5%)", "Delivery Fee"]
    let TaxAmounts = ["₹ 112", "₹ 52", "₹ 50"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
      //  print("Seleced Item array from Singleton is \(addedproducts)")
        
        
    //    self.tableView.reloadData()
        

        // Do any additional setup after loading the view.
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(self.getselectedItems(_:)), name: NSNotification.Name(rawValue: "notificationName"), object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let SharedInstance = CartManager.sharedInstance
        addedproducts = SharedInstance.getcartitemarray() as NSArray
        self.tableView.reloadData()
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
            return addedproducts.count
        }
        if section == 2 {
            return TaxNames.count
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
            print("added products indexpath \(addedproducts[indexPath.row])")
            let dict : NSDictionary  = self.addedproducts[indexPath.row] as! NSDictionary
            cell2.numberlabel.text = "1"
            let pricestring  = String.init(format: "₹ %@", dict.value(forKey: "item_price") as! String)
            cell2.priceLabel.text = pricestring
            cell2.titleLabel.text = (dict.value(forKey: "item_name") as! String)
            
            
            return cell2
        }
        
        else {
            let cell3 = tableView.dequeueReusableCell(withIdentifier: "TaxCell", for: indexPath)
            if indexPath.section == 2 {
            cell3.textLabel?.text = TaxNames[indexPath.row]
            cell3.detailTextLabel?.text = TaxAmounts[indexPath.row]
            }
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
