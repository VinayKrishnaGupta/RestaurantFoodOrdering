//
//  MyOrdersViewController.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 05/06/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import Alamofire

class MyOrdersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var myOrderTableView: UITableView!
    var MyorderList : NSArray = []

    override func viewDidLoad() {
        super.viewDidLoad()
        myOrderTableView.dataSource = self
        myOrderTableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        let HEADERS: HTTPHeaders = [
            "Token": "d75542712c868c1690110db641ba01a",
            "Accept": "application/json",
            "Merchantname" : "admin",
            "Merchantid" : "3",
            "Connection" : "close"
        ]
        var UserID = "N"
        var MobileNumber = ""
        
        if (UserDefaults.standard.dictionary(forKey: "LoggedInUser")) != nil {
            let userDict : NSDictionary = UserDefaults.standard.dictionary(forKey: "LoggedInUser")! as NSDictionary
            UserID = userDict.value(forKey: "enduser_id") as! String
            let mobile : String = userDict.value(forKey: "enduser_mobile") as! String
            let arr = mobile.components(separatedBy: "-")
           MobileNumber = arr[1]
        }
        else {
            UserID = "N"
            
        }
        
        
        let parameters2 = ["user_id":UserID, "mobile" : MobileNumber] as [String : String]
        

        
        Alamofire.request( URL(string: "https://pay-hub.in/payhub%20api/v1/order_history.php")!, method: .post, parameters: parameters2, headers: HEADERS )
            
            
            .responseJSON { response in
                debugPrint(response)
                
                
                if let json = response.result.value {
                    let dict = json as! NSDictionary
                    print(dict)
                    let responsetype : String = dict.value(forKeyPath: "Response.status.type") as! String
                    if responsetype == "Success" {
                        self.myOrderTableView.isHidden = false
                        self.MyorderList = dict.value(forKeyPath: "Response.data.orders") as! NSArray
                        self.myOrderTableView.reloadData()
                    }
                    
                    else {
                        self.myOrderTableView.isHidden = true
                        let label = UILabel(frame: CGRect(x: 0, y:0, width: 200, height: 21))
                        label.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
                        label.textAlignment = .justified
                        label.text = "You are not Logged In"
                        self.view.addSubview(label)
                        
                    }
                    
                    
                   
                    
                    
                }
                
        }
        

        
        
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return MyorderList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myOrderTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyOrdersTableViewCell
        let dict : NSDictionary = MyorderList.object(at: indexPath.section) as! NSDictionary
        
        
        cell.transactionIDLabel.text = "Transation Id: " + (dict.value(forKey: "order_txn_id") as! String)
        cell.orderDateLabel.text = (dict.value(forKey: "order_txn_date") as! String)
        
        cell.orderListLabel.text = (dict.value(forKey: "order_list") as! String)
        cell.OrderStatusLabel.text = (dict.value(forKey: "order_status") as! String)
        cell.OrderPriceLabel.text = "₹ " + (dict.value(forKey: "order_price") as! String)
        
        
        
        
        
        
        return cell
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
