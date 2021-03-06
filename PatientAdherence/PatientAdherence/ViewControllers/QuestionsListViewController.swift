//
//  QuestionsListViewController.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/15/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class QuestionsListViewController: UIViewController {
    
    let questionsTableView = QuestionsTableView(data: FakeData.headers)
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "Education Academy"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        self.questionsTableView.delegate = self
        
        self.view.addSubview(self.questionsTableView)
        addConstraints()
    }
    
    func addConstraints() {
        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.questionsTableView, sides: [.left, .top, .right], padding: 0))
        self.view.addConstraint(PConstraint.paddingPositionConstraint(view: self.questionsTableView, side: .bottom, padding: 30))
    }
}

extension QuestionsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.item
        let detailTitle = FakeData.headers[index]
        let specificViewController = SpecificQuestionsViewController(detailTitle: detailTitle)
        
        self.navigationController?.pushViewController(specificViewController, animated: true)
    }
    
}
