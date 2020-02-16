//
//  StarsViewController.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/16/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class StarsViewController: UIViewController {

    let titleLabel = PLabel(font: UIFont.boldSystemFont(ofSize: 24.0), text: "", alignment: .left, textColor: Colors.darkGreen)
    let pointsLabel = PLabel(font: UIFont.boldSystemFont(ofSize: 42.0), text: "", alignment: .left, textColor: UIColor.white)
    let summaryText = PLabel(font: UIFont.systemFont(ofSize: 18.0), text: "", alignment: .center, textColor: UIColor.white)
    let img:PImageView
    
    let right:Bool
    init(title: String, right: Bool) {
        self.titleLabel.text = title.uppercased()
        self.right = right
        if right {
            self.pointsLabel.text = "+200🌟"
            self.summaryText.text = "Congrats!\n\nYou have mastered your glucose guardian fact of the day."
            self.img = PImageView(imgName: "badge")
        } else {
            self.pointsLabel.text = "+50🌟"
            self.summaryText.text = "Nice try!\n\nYou have completed your glucose guardian fact of the day, but will have to revisit it another day to master."
            self.img = PImageView(imgName: "badge_gray")
        }
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Colors.base
        
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.pointsLabel)
        self.view.addSubview(self.summaryText)
        self.view.addSubview(self.img)
        addConstraints()
    }
    
    func addConstraints() {
        self.view.addConstraint(PConstraint.horizontalAlignConstraint(firstView: self.titleLabel, secondView: self.view))
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.titleLabel, lowerView: self.pointsLabel, spacing: 40))
        
        self.view.addConstraint(PConstraint.horizontalAlignConstraint(firstView: self.pointsLabel, secondView: self.view))
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.pointsLabel, lowerView: self.img, spacing: 40))
        
        self.view.addConstraints(PConstraint.centerAlignConstraints(firstView: self.img, secondView: self.view))
        self.view.addConstraints(PConstraint.squareHeightConstraints(view: self.img, squareRatio: 0.3))
        
        self.view.addConstraint(PConstraint.horizontalAlignConstraint(firstView: self.summaryText, secondView: self.view))
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.img, lowerView: self.summaryText, spacing: 40))
        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.summaryText, sides: [.left, .right], padding: 60))
    }
    
}
