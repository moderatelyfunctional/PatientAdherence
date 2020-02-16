//
//  PButton.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/15/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class PButton: UIButton {
        
    let titleColor:UIColor
    let pressedTitleColor:UIColor
    
    init(text: String, titleColor: UIColor, backgroundColor: UIColor, hasBorder: Bool) {
        self.titleColor = backgroundColor
        self.pressedTitleColor = backgroundColor.darker(by: 10)!

        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setTitle(text, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.layer.cornerRadius = 10
        self.backgroundColor = backgroundColor
        if hasBorder {
            self.layer.borderColor = UIColor.white.cgColor
            self.layer.borderWidth = 3
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open var isHighlighted: Bool {
        didSet {
            self.layer.opacity = isHighlighted ? 0.7 : 1.0
//            backgroundColor = isHighlighted ? self.pressedTitleColor : self.titleColor
        }
    }
    
}
