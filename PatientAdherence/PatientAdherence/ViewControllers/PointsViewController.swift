//
//  PointsViewController.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/16/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class PointsViewController: UIViewController {
    
    let label = PLabel(font: UIFont.systemFont(ofSize: 20), text: "What rewards would you like to cash in your points for?", alignment: .center, textColor: UIColor.white)
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Points"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.label)
        addConstraints()
    }
    
    func addConstraints() {
        
    }
    
}
