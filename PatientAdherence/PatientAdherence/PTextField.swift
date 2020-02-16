//
//  PTextField.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/15/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class PTextField: UITextField {
    
    let border:PView!
        
    init(color: UIColor, placeholderText: String) {
        self.border = PView(color: color)
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = color
        self.text = text
        self.placeholder = placeholderText
        self.font = UIFont.systemFont(ofSize: 20)
        
        self.tintColor = color
        self.borderStyle = .none
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: color])
        
        self.addSubview(self.border)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.addConstraints(PConstraint.paddingPositionConstraints(view: self.border, sides: [.left, .bottom, .right], padding: 0))
        self.addConstraint(PConstraint.constantConstraint(view: self.border, attribute: .height, value: 3))
    }
    
    
    
}
