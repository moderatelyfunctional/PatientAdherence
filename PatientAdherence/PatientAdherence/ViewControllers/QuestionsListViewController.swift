//
//  QuestionsListViewController.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/15/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class QuestionsListViewController: UINavigationController, UITableViewDelegate {
    
    let questionsTableView = QuestionsTableView(data: FakeData.headers)
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = "Education Academy"

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.questionsTableView)
        
        addConstraints()
    }
    
    func addConstraints() {
        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.questionsTableView, sides: [.left, .bottom, .right], padding: 0))
        self.view.addConstraint(PConstraint.fillYConstraints(view: self.questionsTableView, heightRatio: 0.7))
    }
    
}

