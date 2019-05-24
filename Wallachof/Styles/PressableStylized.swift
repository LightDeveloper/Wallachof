//
//  File.swift
//  Wallachof
//
//  Created by Dev2 on 23/05/2019.
//  Copyright © 2019 Dev2. All rights reserved.
//

import Foundation
import SwiftyButton

class PressableStylized: PressableButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        colors = ColorSet(button: .buttonForeground, shadow: .buttonBorder)
    }

}
