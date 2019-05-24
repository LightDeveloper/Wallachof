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
    var animator: UIDynamicAnimator!
    
    @IBOutlet weak var lblLogo: UILabel!
    @IBOutlet weak var viewForm: UIView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var txtfEmail: UITextField!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var txtfPassword: UITextField!
    @IBOutlet weak var btnSignIn: PressableStylized!
    @IBOutlet weak var btnSignUp: PressableStylized!
    @IBOutlet weak var btnAbout: UIButton!
    @IBOutlet weak var viewFloor: UIView!
    @IBOutlet weak var activityLoading: UIActivityIndicatorView!
    
    // Constrains
    @IBOutlet weak var consLblLogoTop: NSLayoutConstraint!
    @IBOutlet weak var consBtnSignInCenter: NSLayoutConstraint!
    @IBOutlet weak var consBtnSignUpCenter: NSLayoutConstraint!
    
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
        btnAbout.setTitle("about".localize(), for: .normal)
    }

}

// Animaciones
extension LoginViewController  {
    
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
        }) { (finished) in
            self.startViewFormBeating()
            
        }
    }
    
    func startViewFormBeating() {
        UIView.animate(withDuration: 0.9,
                       delay: 0.0,
                       options: [.autoreverse, .repeat, .curveEaseInOut, .allowUserInteraction],
                       animations: {
                        self.viewForm.layer.transform =  CATransform3DMakeRotation(CGFloat(Double.pi / 5), 1.0, 0.0, 0.0)
//                        self.viewForm.layer.transform =  CATransform3DMakeScale(1.05, 1.05,  1.0)
        }, completion: nil)
        
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

extension LoginViewController: UIDynamicAnimatorDelegate {
    
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        debugPrint("He terminado de animar")
        activityLoading.stopAnimating()
    }
    
}
