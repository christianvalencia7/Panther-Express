//
//  FormTextField.swift
//  Panther Express
//
//  Created by Christian Valencia on 7/18/20.
//  Copyright © 2020 PantherHacks. All rights reserved.
//

import UIKit

@IBDesignable
class FormTextField: UITextField {

    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
        
    }
}
