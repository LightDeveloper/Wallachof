//
//  AppAppearance.swift
//  Wallachof
//
//  Created by Dev2 on 23/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import UIKit

extension UIView {

    func addStripesBackground() {
        let bgPattern = UIImage(named: "bg-login")
        backgroundColor = UIColor(patternImage: bgPattern!)  
    }
    
    @IBInspectable
    var border: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.cornerRadius = 10.0
            layer.borderWidth = border
            layer.borderColor = UIColor.black.cgColor
        }
    }
    
    func addShadow() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 10.0
    }
    
}
