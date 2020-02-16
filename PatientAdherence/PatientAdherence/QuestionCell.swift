//
//  QuestionCell.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/15/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {
    
    let nameLabel = PLabel(font: UIFont.systemFont(ofSize: 16.0), text: "", alignment: .left, textColor: Colors.grey)
    let percentage = PLabel(font: UIFont.systemFont(ofSize: 16.0), text: "", alignment: .left, textColor: Colors.grey)
    
    init(name: String, percentage: CGFloat) {
        super.init(style: .default, reuseIdentifier: "questionCell")
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.selectionStyle = .none
        
        self.nameLabel.text = name
        if percentage < 0.4 {
            self.percentage.textColor = Colors.red
        } else if percentage < 0.75 {
            self.percentage.textColor = Colors.yellow
        } else {
            self.percentage.textColor = Colors.grey
        }
        self.percentage.text = String(format: "%.1f", percentage)
        
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.percentage)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.contentView.addConstraint(PConstraint.paddingPositionConstraint(view: self.percentage, side: .left, padding: 60))
        self.contentView.addConstraints(PConstraint.paddingPositionConstraints(view: self.percentage, sides: [.top, .bottom], padding: 20))
        
        self.contentView.addConstraint(PConstraint.horizontalSpacingConstraint(leftView: self.percentage, rightView: self.nameLabel, spacing: 40))
        self.contentView.addConstraints(PConstraint.paddingPositionConstraints(view: self.nameLabel, sides: [.top, .bottom], padding: 20))
    }
    
}
