//
//  PView.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/15/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class PView: UIView {
    
    init(color: UIColor) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
