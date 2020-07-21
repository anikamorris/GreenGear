//
//  TextField+Placeholder.swift
//  GreenGear
//
//  Created by Anika Morris on 7/20/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation
import UIKit


extension UITextField {
    func setPlaceholder(text: String) {
        self.attributedPlaceholder = NSAttributedString(string: text,
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightText])
    }
}
