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
        
        let wallachofClient: WallachofClient = WallachofClientImpl()
        wallachofClient.login(email: email, password: password) { (result) in
            
            switch result {
            case .success(let user):
                debugPrint("\(user.name) su conejo es \(String(describing: user.pet?.name)) ")
            case .error(let apiError):
                switch apiError {
                case .malformedURL(let url):
                    debugPrint("Error de producción \(url)")
                case .couldNotGetStatusCode:
                    debugPrint("Error de comunicación")
                case .couldNotDecodeJSON:
                    debugPrint("Error de datos")
                case .badStatus(let status, let jsonError):
                    debugPrint("Error de status \(status): \(String(describing: jsonError))")
                case .other(let error):
                    debugPrint(error.localizedDescription)
                }
            }
            
        }
        
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (_) in
            self.view.stopLoginAnimation()
        }
    }    
}
