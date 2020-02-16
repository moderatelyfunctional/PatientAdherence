//
//  QACell.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/15/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class QACell: UITableViewCell {
    
    let nameLabel = PLabel(font: UIFont.systemFont(ofSize: 20.0), text: "", alignment: .left, textColor: Colors.grey)
    let questionText:String
    
    let badge = PImageView(imgName: "badge_gray")
    
    init(questionText: String) {
        self.questionText = questionText
        super.init(style: .default, reuseIdentifier: "QACell")
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.selectionStyle = .none
        self.backgroundColor = UIColor.white
        
        self.nameLabel.text = "asdf slkf sjdf"
//        self.nameLabel.text = self.questionText.components(separatedBy: " ")[0...5].joined(separator: " ") + "..."
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.badge)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.contentView.addConstraint(PConstraint.paddingPositionConstraint(view: self.nameLabel, side: .top, padding: 30))
        self.contentView.addConstraint(PConstraint.paddingPositionConstraint(view: self.nameLabel, side: .bottom, padding: 0))
        self.contentView.addConstraints(PConstraint.paddingPositionConstraints(view: self.nameLabel, sides: [.left, .right], padding: 100))
        
        self.contentView.addConstraint(PConstraint.verticalAlignConstraint(firstView: self.badge, secondView: self.nameLabel))
        self.contentView.addConstraint(PConstraint.horizontalSpacingConstraint(leftView: self.badge, rightView: self.nameLabel, spacing: 20))
        self.contentView.addConstraints(PConstraint.squareWidthConstraints(view: self.badge, squareRatio: 0.10))
        
    }
    
}
