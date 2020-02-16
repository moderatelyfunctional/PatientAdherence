//
//  PointsImg.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/16/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class PointsImg: UIView {
    
    let imgView:PImageView
    let nameLabel:PLabel
    init(imgName: String, name: String) {
        self.imgView = PImageView(imgName: imgName)
        self.nameLabel = PLabel(font: UIFont.systemFont(ofSize: 14.0), text: name, alignment: .center, textColor: UIColor.white)
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.imgView)
        self.addSubview(self.nameLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        
    }
    
}
