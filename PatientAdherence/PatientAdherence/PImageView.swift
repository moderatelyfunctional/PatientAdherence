//
//  PImageView.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/16/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class PImageView: UIImageView {
    
    init(imgName: String) {
        super.init(image: UIImage(named: imgName))
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
