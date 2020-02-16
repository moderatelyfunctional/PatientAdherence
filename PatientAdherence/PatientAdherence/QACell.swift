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
    
    init(questionText: String) {
        self.questionText = questionText
        super.init(style: .default, reuseIdentifier: "QACell")
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = UIColor.white
        
        self.nameLabel.text = self.questionText.components(separatedBy: " ")[0...5].joined(separator: " ")
        self.contentView.addSubview(self.nameLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.contentView.addConstraint(PConstraint.paddingPositionConstraint(view: self.nameLabel, side: .top, padding: 30))
        self.contentView.addConstraint(PConstraint.paddingPositionConstraint(view: self.nameLabel, side: .bottom, padding: 0))
        self.contentView.addConstraints(PConstraint.paddingPositionConstraints(view: self.nameLabel, sides: [.left, .right], padding: 60))

    }
    
}
