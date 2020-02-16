//
//  TakePicture.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/15/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class TakePicture: UIView {
    
    let picture = Picture()
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 4
        
        self.addSubview(self.picture)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.addConstraints(PConstraint.centerAlignConstraints(firstView: self.picture, secondView: self))
        self.addConstraints(PConstraint.squareWidthConstraints(view: self.picture, squareRatio: 0.5))
    }
    
}
