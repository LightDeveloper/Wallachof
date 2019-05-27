//
//  SignInPresenter.swift
//  Wallachof
//
//  Created by Dev2 on 27/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

protocol SignInPresenter: class {
    func login(email: String, password: String)
}

class SignInPresenterImpl: SignInPresenter {
    
    weak private var view: SignInView!
    
    init(view: SignInView) {
        self.view = view
    }
    
    func login(email: String, password: String) {
        
//        if StringValidations.isValidEmail(email) {
        
        if !email.isValidEmail {
            view.showInvalidEmail()
            return
        }

        if password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            view.showInvalidPassword()
            return
        }
        
        view.startLoginAnimation()
        
        let authService: AuthService = AuthServiceImpl()
        
        authService.login(email: email, password: password) { (result, error) in
            
            if error != nil {
//                view.showCommsError()
                return
            }
            
            if let result = result {
                debugPrint("Resultado es \(result)")
            }
            
        }
        
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (_) in
            self.view.stopLoginAnimation()
        }
    }    
}
