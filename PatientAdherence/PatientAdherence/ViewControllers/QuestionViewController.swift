//
//  QuestionViewController.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/16/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    let question:String
    let key:String
    let index:Int
    
    init(question: String, key: String, index: Int) {
        self.question = question
        self.key = key
        self.index = index
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
