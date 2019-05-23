//
//  AppAppearance.swift
//  Wallachof
//
//  Created by Dev2 on 23/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

class UIViewStylized: UIView {

    @IBInspectable
    var addBackgroundPattern: String {
        get {
            return ""
        }
        set {
            if newValue == "" {
                return
            }
            let bgPattern = UIImage(named: newValue)
            backgroundColor = UIColor(patternImage: bgPattern!)
        }
    }
    
    @IBInspectable
    var addBorder: Bool {
        get {
            return layer.borderWidth > 0.0
        }
        set {
            if !newValue {
                return
            }
            layer.cornerRadius = 10.0
            layer.borderWidth = 2.0
            layer.borderColor = UIColor.black.cgColor
        }
    }
    
    @IBInspectable
    var addShadow: Bool {
        get {
            return layer.shadowRadius > 0.0
        }
        set {
            if !newValue {
                return
            }
            
            layer.shadowColor = UIColor.gray.cgColor
            layer.shadowOpacity = 0.8
            layer.shadowRadius = 10.0
        }
    }
    
}
