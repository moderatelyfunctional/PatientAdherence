//
//  SpecificQuestionsViewController.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/15/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class SpecificQuestionsViewController: UIViewController {
    
    let specificTableView:SpecificTableView
    
    init(detailTitle: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.title = detailTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
