//
//  QuestionsListViewController.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/15/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class QuestionsListViewController: UIViewController, UITableViewDelegate {
    
    let questionsTableView = QuestionsTableView(data: FakeData.headers)
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "Education Academy"

        self.view.backgroundColor = UIColor.white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.questionsTableView)
        
        addConstraints()
    }
    
    func addConstraints() {
        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.questionsTableView, sides: [.left, .top, .bottom, .right], padding: 0))
    }
    
}

