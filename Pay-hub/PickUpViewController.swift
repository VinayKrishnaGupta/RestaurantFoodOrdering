//
//  PickUpViewController.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 01/06/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class PickUpViewController: UIViewController {
    @IBOutlet weak var mapview: MKMapView!
   let annotation = MKPointAnnotation()
    let pickUpAddress: String = "PLOT NO B-25, INSTITUTIONAL AREA, SECTOR-32, GURUGRAM, 122003, HARYANA, INDIA"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let locationCorodinate = CLLocationCoordinate2D(latitude: 28.448996, longitude: 77.040409)
        annotation.coordinate = locationCorodinate
        annotation.title = "PayHub Office"
        let myregion = MKCoordinateRegionMakeWithDistance(locationCorodinate, 2000, 2000)
        mapview.addAnnotation(annotation)
        mapview.region = myregion
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func reviewOrder(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "revieworder", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "revieworder" {
            if let nextViewController = segue.destination as? ReviewOrderViewController{
                
                nextViewController.DeliveryType = "pickup"
                    
                }
                 // let destinationViewController = nextViewController.viewControllers?[0] as! MenuItemListViewController
            
            
            
            
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
