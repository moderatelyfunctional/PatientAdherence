//
//  SpecificQuestionsViewController.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/15/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class SpecificQuestionsViewController: UIViewController {
    
    let specificTableView:SpecificTableView!
    
    init(detailTitle: String) {
        self.specificTableView = SpecificTableView(data: FakeData.diabetes[detailTitle]!)
        super.init(nibName: nil, bundle: nil)
        
        self.title = detailTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.specificTableView.delegate = self
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.specificTableView)
        addConstraints()
    }
    
    func addConstraints() {
        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.specificTableView, sides: [.left, .top, .right], padding: 0))
        self.view.addConstraint(PConstraint.paddingPositionConstraint(view: self.specificTableView, side: .bottom, padding: 30))
    }
}

extension SpecificQuestionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = FakeData.diabetes[self.title!]![indexPath.row]
        let questionViewController = QuestionViewController(question: data, key: self.title!, index: indexPath.row)
        self.navigationController?.pushViewController(questionViewController, animated: true)
    }
    
}
