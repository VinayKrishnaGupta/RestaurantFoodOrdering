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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let locationCorodinate = CLLocationCoordinate2D(latitude: 28.448996, longitude: 77.040409)
        annotation.coordinate = locationCorodinate
        let myregion = MKCoordinateRegionMakeWithDistance(locationCorodinate, 2000, 2000)
        mapview.addAnnotation(annotation)
        mapview.region = myregion
        
        
        // Do any additional setup after loading the view.
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
