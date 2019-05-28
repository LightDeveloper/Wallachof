//
//  AboutViewController.swift
//  Wallachof
//
//  Created by Dev2 on 28/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {

    @IBOutlet weak var webAbout: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let myURL = URL(string:"https://www.apple.com")            
        let myRequest = URLRequest(url: myURL!)
        webAbout.load(myRequest)            
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension AboutViewController {
    
}
