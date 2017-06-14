//
//  SideMenuViewController.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 13/04/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import SideMenuController
//public var sideMenuController: SideMenuController?
class SideMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    var TitleList : Array = ["Logo", "Home", "About Us", "My Orders", "Contact Us", "Sign Out"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
      
        
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TitleList[indexPath.row], for: indexPath) as UITableViewCell
        
        if indexPath.row == 0 {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width-20, height: cell.frame.size.height))
            //imageView.clipsToBounds = true
            let image = UIImage(named: "PayhubLogoSideBar")
            imageView.image = image
            cell.backgroundView = UIView()
            
            cell.backgroundView!.addSubview(imageView)
            
//            cell.backgroundView = UIView()
//            cell.backgroundView?.backgroundColor = UIColor(patternImage: UIImage(named: "PayhubLogoWeb")!)

            cell.textLabel?.isHidden = true
            cell.accessoryType = .none
            
        }
        else {
            
            cell.textLabel?.text = TitleList[indexPath.row]
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150
            
        }
        
        else  {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < 4 {
            if indexPath.row == 0
            {
                
            }
            else
            {
                
               sideMenuController?.performSegue(withIdentifier: TitleList[indexPath.row], sender: nil)
            }
            
            
        }
        else if indexPath.row == 4 {
            let storyboard : UIStoryboard = UIStoryboard(name: "ChatMain", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ChatMain")
            self.present(vc, animated: true, completion: nil)
            
            
            
       // callNumber(phoneNumber: "+918436299719")
            }
        else if indexPath.row == 5 {
            let alert = UIAlertController(title: "Sign out", message: "Are you sure to sign out ?", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
            let button2 = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: logout)
            alert.addAction(button2)
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        }
        
        }
    func logout(action:UIAlertAction) {
        UserDefaults.standard.removeObject(forKey: "LoggedInUser")
        UserDefaults.standard.synchronize()
        let sharedInstance = CartManager.sharedInstance
        sharedInstance.NumberofIteminCart = 0
        sideMenuController?.performSegue(withIdentifier: "Home", sender: nil)
        print("Logged Out")
        
    }
        
        
    
    
    
    private func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
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
