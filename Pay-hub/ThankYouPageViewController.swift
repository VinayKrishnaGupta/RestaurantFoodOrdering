//
//  ThankYouPageViewController.swift
//  Pay-hub
//
//  Created by RSTI E-Services on 25/05/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

import UIKit


class ThankYouPageViewController: UIViewController, UIWebViewDelegate {
    var ordernumber = ""
    var PaymentURL = ""

    @IBOutlet weak var paymentWebview: UIWebView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentWebview.delegate = self
        if let url = URL(string: PaymentURL) {
            var request = URLRequest(url: url)
            request.addValue("app", forHTTPHeaderField: "source")
            request.addValue(ordernumber, forHTTPHeaderField: "order")
            
            paymentWebview.loadRequest(request)

        // Do any additional setup after loading the view.
    }
    }
    override func viewWillAppear(_ animated: Bool) {
     
        
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("Webview start load")
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("Webview finish load")
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("Webview failed")
    }
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print("Webview should start")
        if navigationType == UIWebViewNavigationType.linkClicked  {
            paymentWebview.removeFromSuperview()
        }
        let redirectURL = URL(string: "https://pay-hub.in/tpl/demo/admin/3/thankyou")
        if request.url == redirectURL {
            
            //self.perform(#selector(redirect), with: self, afterDelay: 5)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
