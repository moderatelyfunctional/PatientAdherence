//
//  PLabel.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/15/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class PLabel: UILabel {
    
    init(font: UIFont, text: String, alignment: NSTextAlignment, textColor: UIColor) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.numberOfLines = 0
        self.font = font
        self.text = text
        self.textAlignment = alignment
        self.textColor = textColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
