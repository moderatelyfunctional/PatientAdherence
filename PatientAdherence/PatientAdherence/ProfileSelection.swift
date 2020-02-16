//
//  ProfileSelection.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/16/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class ProfileSelection: UIView {
    
    let img:PImageView
    let label:PLabel
    
    init(imgName: String, text: String) {
        self.img = PImageView(imgName: imgName)
        self.label = PLabel(font: UIFont.systemFont(ofSize: 18.0), text: text, alignment: .center, textColor: Colors.base)
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
        
        self.layer.borderColor = Colors.grey.cgColor
        self.layer.borderWidth = 1
        
        self.addSubview(self.img)
        self.addSubview(self.label)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.addConstraints(PConstraint.squareHeightConstraints(view: self.img, squareRatio: 0.3))
        self.addConstraint(PConstraint.horizontalAlignConstraint(firstView: self.img, secondView: self))
        self.addConstraint(NSLayoutConstraint(item: self.img, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: -50))
        
        self.addConstraint(PConstraint.horizontalAlignConstraint(firstView: self.label, secondView: self))
        self.addConstraint(NSLayoutConstraint(item: self.label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 50))

    }
    
}
