//
//  LoginViewController.swift
//  Wallachof
//
//  Created by Dev2 on 23/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var animationStarted = false
    
    @IBOutlet weak var lblLogo: UILabel!
    @IBOutlet weak var viewForm: UIView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtfEmail: UITextField!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var txtfPassword: UITextField!
    @IBOutlet weak var btnSignIn: PressableStylized!
    @IBOutlet weak var btnSignUp: PressableStylized!
    
    
    // Constrains
    @IBOutlet weak var consLblLogoTop: NSLayoutConstraint!
    @IBOutlet weak var consBtnSignInCenter: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareAnimations()
        localizeViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        view.translatesAutoresizingMaskIntoConstraints = false
//        viewForm.topAnchor.constraint(equalTo: lblLogo.bottomAnchor, constant: 20.0).isActive = true
//        let consOtra = NSLayoutConstraint(item: btnLogin, attribute: .bottom, relatedBy: .equal, toItem: viewForm, attribute: .top, multiplier: 1.0, constant: 30.0)
//        view.addConstraint(consOtra)
//        view.addConstraints([consOtra])
        
        if !animationStarted {
            animationStarted = true
            startLogoAnimation()
        }
        
    }
    
}

// Traducciones
extension LoginViewController {
    
    func localizeViews() {
        lblEmail.text = "email".localize()
        lblPassword.text = "password".localize()
        btnSignIn.setTitle("signin".localize(), for: .normal)
        btnSignUp.setTitle("signup".localize(), for: .normal)
    }

}

// Animaciones
extension LoginViewController  {
    
    func prepareAnimations() {
        viewForm.alpha = 0.0
        consLblLogoTop.constant = -(lblLogo.frame.height + view.safeAreaInsets.bottom)
        consBtnSignInCenter.constant = -(view.frame.width + btnSignIn.frame.width) / 2 - 10.0
    }
    
    func startLogoAnimation() {
        consLblLogoTop.constant = 20
        
        UIView.animate(withDuration: 2.0,
                       delay: 0.0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 0.3,
                       options: [],
                       animations: {
                        self.view.layoutIfNeeded()
        }) { (finished) in
            self.startViewFormAnimation()
            self.startBtnLoginAnimation()
        }
    }
    
    func startViewFormAnimation() {
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: [],
                       animations: {
                        self.viewForm.alpha = 1.0
        }) { (finished) in
            
        }
    }
    
    func startBtnLoginAnimation() {
        consBtnSignInCenter.constant = 0
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: [.curveEaseOut],
                       animations: {
                        self.view.layoutIfNeeded()
        }, completion: { (finished) in
            
        })
    }
    
}
