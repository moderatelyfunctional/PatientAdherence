//
//  PictureViewController.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/15/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController {
    
    let titleLabel = PLabel(
        font: UIFont.systemFont(ofSize: 40.0),
        text: "Hi! Create your account here.",
        alignment: .left,
        textColor: UIColor.white)
    let takePicture = TakePicture()

    init(name: String) {
        self.titleLabel.text = "Hi \(name), upload a photo!"
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = Colors.baseColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.takePicture)
        addConstraints()
    }
    
    func addConstraints() {
        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.titleLabel, sides: [.left, .right], padding: 60))
        self.view.addConstraint(PConstraint.paddingPositionConstraint(view: self.titleLabel, side: .top, padding: 100))
        
        self.view.addConstraints(PConstraint.centerAlignConstraints(firstView: self.takePicture, secondView: self.view))
        self.view.addConstraints(PConstraint.squareWidthConstraints(view: self.takePicture, squareRatio: 0.7))
    }
    
    
}
