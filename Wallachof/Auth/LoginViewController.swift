//
//  LoginViewController.swift
//  Wallachof
//
//  Created by Dev2 on 23/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var lblLogo: UILabel!
    @IBOutlet weak var viewForm: UIView!
    @IBOutlet weak var txtfEmail: UITextField!
    @IBOutlet weak var txtfPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyles()
    }
    
    func setupStyles() {
        view.addStripesBackground()
        viewForm.addShadow()
    }
    
}
