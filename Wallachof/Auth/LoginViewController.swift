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
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtfEmail: UITextField!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var txtfPassword: UITextField!
    @IBOutlet weak var btnLogin: PressableStylized!
    @IBOutlet weak var consButtonCenter: NSLayoutConstraint!
    @IBOutlet weak var consButtonWidth: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateLogo()
        setupLanguage()
    }
    
    func setupLanguage() {
//        lblEmail.text = "email".localize()
//        lblPassword.text = "password".localize()
        btnLogin.setTitle("login".localize(), for: .normal)
    }
    
    func animateLogo() {
        
        lblLogo.alpha = 0.0
        UIView.animate(withDuration: 1.0) {
            self.lblLogo.alpha = 1.0
        }
        
//        UIView.animate(withDuration: <#T##TimeInterval#>, delay: <#T##TimeInterval#>, options: <#T##UIView.AnimationOptions#>, animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
//

        UIView.animate(withDuration: 4.0, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .allowUserInteraction, animations: {
            self.consButtonWidth.constant = 180.0
        }) { (finished) in
            self.consButtonWidth.constant = 120.0
        }
        
    }

}
