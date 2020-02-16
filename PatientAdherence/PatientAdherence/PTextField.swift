//
//  PTextField.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/15/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class PTextField: UITextField {
    
    init(text: String, placeholderText: String) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = UIColor.white
        self.text = text
        self.placeholder = placeholderText
//        self._placehol
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
