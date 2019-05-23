//
//  String+Localized.swift
//  Wallachof
//
//  Created by Dev2 on 23/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation

extension String {
    
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
}
