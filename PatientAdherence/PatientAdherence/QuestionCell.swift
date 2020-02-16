//
//  QuestionCell.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/15/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {
    
    let nameLabel = PLabel(font: UIFont.systemFont(ofSize: 20.0), text: "", alignment: .left, textColor: Colors.grey)
    let percentage = PLabel(font: UIFont.systemFont(ofSize: 20.0), text: "", alignment: .right, textColor: Colors.grey)
    
    init(name: String, percentage: CGFloat) {
        super.init(style: .default, reuseIdentifier: "questionCell")
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.selectionStyle = .none
        
        self.backgroundColor = UIColor.white
        
        self.nameLabel.text = name
        if percentage < 40 {
            self.percentage.textColor = Colors.red
        } else if percentage < 75 {
            self.percentage.textColor = Colors.yellow
        } else {
            self.percentage.textColor = Colors.grey
        }
        self.percentage.text = String(format: "%.0f%%", percentage)
        
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.percentage)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.contentView.addConstraints(PConstraint.paddingPositionConstraints(view: self.nameLabel, sides: [.left, .right], padding: 120))
        
        self.contentView.addConstraint(PConstraint.paddingPositionConstraint(view: self.nameLabel, side: .top, padding: 30))
        self.contentView.addConstraint(PConstraint.paddingPositionConstraint(view: self.nameLabel, side: .bottom, padding: 0))

        self.contentView.addConstraint(PConstraint.horizontalSpacingConstraint(leftView: self.percentage, rightView: self.nameLabel, spacing: 20))
        self.contentView.addConstraint(PConstraint.paddingPositionConstraint(view: self.percentage, side: .top, padding: 30))
        self.contentView.addConstraint(PConstraint.paddingPositionConstraint(view: self.percentage, side: .bottom, padding: 0))


    }
    
}
