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
    
    func setLeftPaddingPoints(_ amount: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setPaddingPoints(_ amount: CGFloat) {
        self.setLeftPaddingPoints(amount)
        self.setRightPaddingPoints(amount)
    }
}
