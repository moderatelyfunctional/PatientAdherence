//
//  PointsViewController.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/16/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class PointsViewController: UIViewController {
    
    let label = PLabel(font: UIFont.systemFont(ofSize: 24), text: "What rewards would you like to cash in your points for?", alignment: .center, textColor: UIColor.white)
    
    let coffeeImg = PImageView(imgName: "points_starbucks")
    let coffeeLabel = PLabel(font: UIFont.systemFont(ofSize: 24), text: "coffee", alignment: .center, textColor: UIColor.white)

    let travelImg = PImageView(imgName: "points_airmiles")
    let travelLabel = PLabel(font: UIFont.systemFont(ofSize: 24), text: "travel", alignment: .center, textColor: UIColor.white)

    let groceriesImg = PImageView(imgName: "points_groceries")
    let groceriesLabel = PLabel(font: UIFont.systemFont(ofSize: 24), text: "groceries", alignment: .center, textColor: UIColor.white)

    let charityImg = PImageView(imgName: "points_charity")
    let charityLabel = PLabel(font: UIFont.systemFont(ofSize: 24), text: "charity", alignment: .center, textColor: UIColor.white)
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Points"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Colors.base
        
        self.view.addSubview(self.label)
        self.view.addSubview(self.coffeeImg)
        self.view.addSubview(self.coffeeLabel)
        self.view.addSubview(self.travelImg)
        self.view.addSubview(self.travelLabel)
        self.view.addSubview(self.groceriesImg)
        self.view.addSubview(self.groceriesLabel)
        self.view.addSubview(self.charityImg)
        self.view.addSubview(self.charityLabel)
        addConstraints()
    }
    
    func addConstraints() {
        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.label, sides: [.left, .right], padding: 60))
        self.view.addConstraint(PConstraint.paddingPositionConstraint(view: self.label, side: .top, padding: 100))
        
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.label, lowerView: self.coffeeImg, spacing: 70))
        self.view.addConstraint(NSLayoutConstraint(item: self.coffeeImg, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 0.55, constant: 0))
        self.view.addConstraints(PConstraint.squareWidthConstraints(view: self.coffeeImg, squareRatio: 0.3))
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.coffeeImg, lowerView: self.coffeeLabel, spacing: 20))
        self.view.addConstraint(PConstraint.horizontalAlignConstraint(firstView: self.coffeeImg, secondView: self.coffeeLabel))
        
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.label, lowerView: self.travelImg, spacing: 70))
        self.view.addConstraint(NSLayoutConstraint(item: self.travelImg, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.45, constant: 0))
        self.view.addConstraints(PConstraint.squareWidthConstraints(view: self.travelImg, squareRatio: 0.3))
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.travelImg, lowerView: self.travelLabel, spacing: 20))
        self.view.addConstraint(PConstraint.horizontalAlignConstraint(firstView: self.travelImg, secondView: self.travelLabel))
        
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.coffeeLabel, lowerView: self.groceriesImg, spacing: 40))
        self.view.addConstraint(PConstraint.horizontalAlignConstraint(firstView: self.groceriesImg, secondView: self.coffeeLabel))
        self.view.addConstraints(PConstraint.squareWidthConstraints(view: self.groceriesImg, squareRatio: 0.3))
        
        self.view.addConstraint(PConstraint.horizontalAlignConstraint(firstView: self.groceriesImg, secondView: self.groceriesLabel))
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.groceriesImg, lowerView: self.groceriesLabel, spacing: 20))
        
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.travelLabel, lowerView: self.charityImg, spacing: 40))
        self.view.addConstraint(PConstraint.horizontalAlignConstraint(firstView: self.charityImg, secondView: self.travelLabel))
        self.view.addConstraints(PConstraint.squareWidthConstraints(view: self.charityImg, squareRatio: 0.3))

        self.view.addConstraint(PConstraint.horizontalAlignConstraint(firstView: self.charityImg, secondView: self.charityLabel))
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.charityImg, lowerView: self.charityLabel, spacing: 20))

    }
    
}
