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
        animateLogo()
    }
    
    func animateLogo() {
        
        lblLogo.alpha = 0.0
        UIView.animate(withDuration: 1.0) {
            self.lblLogo.alpha = 1.0
        }
        
//        UIView.animate(withDuration: <#T##TimeInterval#>, animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
//
//        UIView.animate(withDuration: <#T##TimeInterval#>, delay: <#T##TimeInterval#>, options: <#T##UIView.AnimationOptions#>, animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
//
//
//        UIView.animate(withDuration: <#T##TimeInterval#>, delay: <#T##TimeInterval#>, usingSpringWithDamping: <#T##CGFloat#>, initialSpringVelocity: <#T##CGFloat#>, options: <#T##UIView.AnimationOptions#>, animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
        
    }

}
