//
//  QuestionsTableView.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/15/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class QuestionsTableView: UITableView, UITableViewDataSource {
    
    let data:[String]
    init(data: [String]) {
        self.data = data
        super.init(frame: .zero, style: .plain)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.separatorStyle = .none
        self.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var percentage:CGFloat = 0.0
        for (element, values) in FakeData.diabetesProgress {
            if element == self.data[indexPath.item] {
                percentage = 100 * CGFloat(values.reduce(0, +)) / CGFloat(values.count)
            }
        }
        
        return QuestionCell(name: self.data[indexPath.item], percentage: percentage)
    }
    
    
    
}
