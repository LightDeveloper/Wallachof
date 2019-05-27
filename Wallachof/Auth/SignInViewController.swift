//
//  LoginViewController.swift
//  Wallachof
//
//  Created by Dev2 on 23/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

protocol SignInView: class {
    
    func showInvalidEmail()
    func showInvalidPassword()
    func startLoginAnimation()
    func stopLoginAnimation()
    
}

class SignInViewController: UIViewController {
    
    var presenter: SignInPresenter!
    
    var animationStarted = false
    var animator: UIDynamicAnimator!
    
    @IBOutlet weak var lblLogo: UILabel!
    @IBOutlet weak var viewForm: UIView!
    @IBOutlet weak var stackForm: UIStackView!
    @IBOutlet weak var activityLoading: UIActivityIndicatorView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtfEmail: UITextField!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var txtfPassword: UITextField!
    @IBOutlet weak var btnSignIn: PressableStylized!
    @IBOutlet weak var btnSignUp: PressableStylized!
    @IBOutlet weak var btnAbout: UIButton!
    @IBOutlet weak var viewFloor: UIView!
    
    // Constrains
    @IBOutlet weak var consLblLogoTop: NSLayoutConstraint!
    @IBOutlet weak var consBtnSignInCenter: NSLayoutConstraint!
    @IBOutlet weak var consBtnSignUpCenter: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = SignInPresenterImpl(view: self)
        
        txtfEmail.delegate = self
        txtfPassword.delegate = self
        
        #if DEBUG
        txtfEmail.text = "david@gmail.com"
        txtfPassword.text = "1234"
        #endif
                
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
    
    @IBAction func btnSignInPressed(_ sender: Any) {
        executeLogin()
    }
    
    func executeLogin() {
        view.endEditing(true)
        presenter.login(email: txtfEmail.text!, password: txtfPassword.text!)
    }
    
}

extension SignInViewController: SignInView {
    
    func showInvalidEmail() {
        txtfEmail.shake()
        txtfEmail.becomeFirstResponder()
    }
    
    func showInvalidPassword() {
        txtfPassword.shake()
        txtfPassword.becomeFirstResponder()
    }
    
    func startLoginAnimation() {
        startLoginAnimations()
    }
    
    func stopLoginAnimation() {
        stopLoginAnimations()
    }
    
}

// Control de textfields
extension SignInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtfEmail {
            txtfPassword.becomeFirstResponder()
        } else if textField == txtfPassword {
            executeLogin()
        }
        
        return true
    }
    
}


// Traducciones
extension SignInViewController {
    
    func localizeViews() {
        lblEmail.text = "email".localize()
        lblPassword.text = "password".localize()
        btnSignIn.setTitle("signin".localize(), for: .normal)
        btnSignUp.setTitle("signup".localize(), for: .normal)
        btnAbout.setTitle("about".localize(), for: .normal)
    }

}

// Animaciones
extension SignInViewController  {
    
    func prepareAnimations() {
        viewForm.alpha = 0.0
        btnAbout.isHidden = true
        
        consLblLogoTop.constant = -(lblLogo.frame.height + view.safeAreaInsets.bottom)
        consBtnSignInCenter.constant = -(view.frame.width + btnSignIn.frame.width) / 2 - 20.0
        consBtnSignUpCenter.constant =  (view.frame.width + btnSignUp.frame.width) / 2 + 20.0
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
            self.startBtnSignInAnimation()
            self.startBtnSignUpAnimation()
            self.startBtnAboutAnimation()
        }
    }
    
    func startViewFormAnimation() {
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: [],
                       animations: {
                        self.viewForm.alpha = 1.0
        })
    }
    
    func startLoginAnimations() {
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: [.curveEaseInOut],
                       animations: {
                        self.btnSignIn.alpha = 0
                        self.btnSignUp.alpha = 0
                        self.btnAbout.alpha = 0
                        self.stackForm.alpha = 0
                        
                        self.activityLoading.alpha = 1
                        self.activityLoading.startAnimating()
                        
                        self.viewForm.layer.transform =  CATransform3DMakeRotation(CGFloat(Double.pi), 0.0, 1.0, 0.0)
        })
    }

    func stopLoginAnimations() {
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: [.curveEaseInOut],
                       animations: {
                        self.btnSignIn.alpha = 1
                        self.btnSignUp.alpha = 1
                        self.btnAbout.alpha = 1
                        self.stackForm.alpha = 1
                        
                        self.activityLoading.alpha = 0
                        self.activityLoading.stopAnimating()
                        
                        self.viewForm.layer.transform =  CATransform3DMakeRotation(0, 0.0, 1.0, 0.0)
        })
    }

    func startBtnSignInAnimation() {
        consBtnSignInCenter.constant = 0
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: [.curveEaseOut],
                       animations: {
                        self.view.layoutIfNeeded()
        }, completion: { (finished) in
            
        })
    }
    
    func startBtnSignUpAnimation() {
        consBtnSignUpCenter.constant = 0
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: [.curveEaseOut],
                       animations: {
                        self.view.layoutIfNeeded()
        }, completion: { (finished) in
            
        })
    }
    
    
    func startBtnAboutAnimation() {
        btnAbout.isHidden = false
        btnAbout.frame.origin.y = -btnAbout.frame.height*0.5

        animator = UIDynamicAnimator(referenceView: view)
        animator.delegate = self
        
        let gravity = UIGravityBehavior(items: [btnAbout])
        animator.addBehavior(gravity)
        
        let collision = UICollisionBehavior(items: [btnAbout])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        
//        let from = CGPoint(x: 0, y: btnSignUp.frame.maxY + btnAbout.frame.height + 40.0)
//        let to = CGPoint(x: view.frame.width, y: btnSignUp.frame.maxY + btnAbout.frame.height + 85.0)
//
//        let boundaryId = NSString(string: "floor")
//        collision.addBoundary(withIdentifier: boundaryId, from: from, to: to)
        
        let boundaryId = NSString(string: "floor")
        collision.addBoundary(withIdentifier: boundaryId, for: UIBezierPath(rect: viewFloor.frame))
        
        let btnBehaviour = UIDynamicItemBehavior(items: [btnAbout])
        btnBehaviour.allowsRotation = true
        btnBehaviour.elasticity = 0.2
        animator.addBehavior(btnBehaviour)
    }
}

extension SignInViewController: UIDynamicAnimatorDelegate {
    
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        debugPrint("He terminado de animar")
    }
    
}
