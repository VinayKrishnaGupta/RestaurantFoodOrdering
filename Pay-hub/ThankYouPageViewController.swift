//
//  ThankYouPageViewController.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 25/05/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit
import SVProgressHUD


class ThankYouPageViewController: UIViewController, UIWebViewDelegate {
    var ordernumber = ""
    var PaymentURL = ""
    var SuccessUrl = ""
    var FailedURL = ""

    @IBOutlet weak var paymentWebview: UIWebView!
   
    override func viewDidLoad() {
        SVProgressHUD.show()
        super.viewDidLoad()
        let backButton1 = UIBarButtonItem.init(image: UIImage.init(named: "BackButton"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(backAction(_:)))
        
        
        
        self.navigationItem.leftBarButtonItem = backButton1
       

        // Do any additional setup after loading the view.
    
    }
    override func viewWillAppear(_ animated: Bool) {
        
        paymentWebview.delegate = self
        if let url = URL(string: PaymentURL) {
            var request = URLRequest(url: url)
            request.addValue("app", forHTTPHeaderField: "source")
            request.addValue(ordernumber, forHTTPHeaderField: "order")
            
            paymentWebview.loadRequest(request)
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        SVProgressHUD.dismiss()
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("Webview start load")
        SVProgressHUD.show()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss(withDelay: 1)
        print("Webview finish load")
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        SVProgressHUD.dismiss()
        print("Webview failed")
    }
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print("Webview should start")
        if navigationType == UIWebViewNavigationType.linkClicked  {
            paymentWebview.removeFromSuperview()
        }
        
        SVProgressHUD.show()
        
        let failedurl = URL(string: FailedURL)
        let successURL = URL(string: SuccessUrl)
        if request.url == successURL {
            
            let presentingViewController = self.presentingViewController
            self.dismiss(animated: false, completion: {
                presentingViewController!.dismiss(animated: false, completion: {})
            })
            return true
            
        }
        if request.url == failedurl {
            
            self.dismiss(animated: true, completion: nil)
            
            return true
        }
        
            
            

    
        return true
    }

    func redirect() {
        paymentWebview.removeFromSuperview()
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Cancel Payment Process", message: "You will be redirected to Home ?", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
        let button2 = UIAlertAction(title: "Back", style: UIAlertActionStyle.default, handler: cancel)
        let button3 = UIAlertAction(title: "Go to Home", style: UIAlertActionStyle.default, handler: home)
        alert.addAction(button2)
        alert.addAction(button3)
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func cancel(action:UIAlertAction) {
        
        
       self.navigationController?.popViewController(animated: false)
        
        
    }
    
    func home(action:UIAlertAction) {
        
        
        let presentingViewController = self.presentingViewController
        self.dismiss(animated: false, completion: {
            presentingViewController!.dismiss(animated: false, completion: {})
        })
        
        
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
