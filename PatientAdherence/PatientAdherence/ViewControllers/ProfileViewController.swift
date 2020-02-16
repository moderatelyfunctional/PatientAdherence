//
//  ProfileViewController.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/16/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let progress = PLabel(font: UIFont.systemFont(ofSize: 24.0), text: "Progress", alignment: .left, textColor: Colors.base)
    let streak = PLabel(font: UIFont.systemFont(ofSize: 16.0), text: "Your current streak is 10 days.", alignment: .left, textColor: Colors.grey)
    let points = PLabel(font: UIFont.systemFont(ofSize: 16.0), text: "You have 2,000 points to redeem.", alignment: .left, textColor: Colors.grey)
    
    let educationSelection = ProfileSelection(imgName: "education", text: "Education\nAcademy")
    let treatmentSelection = ProfileSelection(imgName: "treatment", text: "Treatment\nSquad")
    let pointsSelection = ProfileSelection(imgName: "points", text: "Points\nDepartment")
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.title = name.james
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.educationSelection.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.switchToEducation)))
        self.pointsSelection.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.switchToPoints)))
        
        self.view.addSubview(self.progress)
        self.view.addSubview(self.streak)
        self.view.addSubview(self.points)
        self.view.addSubview(self.educationSelection)
        self.view.addSubview(self.treatmentSelection)
        self.view.addSubview(self.pointsSelection)
        addConstraints()
    }
    
    func addConstraints() {
        self.view.addConstraint(PConstraint.paddingPositionConstraint(view: self.progress, side: .left, padding: 40))
        self.view.addConstraint(PConstraint.paddingPositionConstraint(view: self.progress, side: .top, padding: 120))
        
        self.view.addConstraint(PConstraint.paddingPositionConstraint(view: self.streak, side: .left, padding: 40))
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.progress, lowerView: self.streak, spacing: 10))
        
        self.view.addConstraint(PConstraint.paddingPositionConstraint(view: self.points, side: .left, padding: 40))
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.streak, lowerView: self.points, spacing: 10))
        
        self.view.addConstraint(PConstraint.fillXConstraints(view: self.educationSelection, widthRatio: 0.5))
        self.view.addConstraint(PConstraint.fillYConstraints(view: self.educationSelection, heightRatio: 0.35))
        self.view.addConstraint(PConstraint.paddingPositionConstraint(view: self.educationSelection, side: .left, padding: 0))
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.points, lowerView: self.educationSelection, spacing: 40))
        
        self.view.addConstraint(PConstraint.fillXConstraints(view: self.treatmentSelection, widthRatio: 0.5))
        self.view.addConstraint(PConstraint.fillYConstraints(view: self.treatmentSelection, heightRatio: 0.35))
        self.view.addConstraint(PConstraint.horizontalSpacingConstraint(leftView: self.educationSelection, rightView: self.treatmentSelection, spacing: 0))
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.points, lowerView: self.treatmentSelection, spacing: 40))
        
        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.pointsSelection, sides: [.left, .bottom, .right], padding: 0))
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.educationSelection, lowerView: self.pointsSelection, spacing: 0))
    }
    
    func processDiabetesData(stringData: String) {
        var headers:[String] = []
        var dataElements:[String: [String]] = [:]
        var dataProgress:[String: [Int]] = [:]

        let jsonData = stringData.components(separatedBy: "$")
        for element in jsonData {
            if element == "" {
                continue
            }
            let elementPipe = element.components(separatedBy: "|")
            let elementSubelement = elementPipe[0].components(separatedBy: "/")
            
            let key = elementSubelement[0].components(separatedBy: "_").joined(separator: " ").capitalized
            
            if !headers.contains(key) {
                headers.append(key)
            }
            if var _ = dataElements[key] {
                dataElements[key]!.append(elementPipe[1])
                dataProgress[key]!.append(0)
            } else {
                dataElements[key] = [elementPipe[1]]
                dataProgress[key] = [0]
            }
            
        }
        FakeData.headers = headers
        FakeData.diabetes = dataElements
        FakeData.diabetesProgress = dataProgress
    }
    
    @objc func switchToEducation() {
        HTTPAPI.instance().call(url: URLS.diabetes, params: nil, method: .GET, success: { (data, response, err) in
            let stringData = String(data: data, encoding: .utf8)!
            self.processDiabetesData(stringData: stringData)
            
            DispatchQueue.main.async {
                let questionsViewController = QuestionsListViewController()
                self.navigationController?.pushViewController(questionsViewController, animated: true)
//                questionsViewController.modalPresentationStyle = .fullScreen
//                self.present(questionsViewController, animated: true, completion: nil)
            }
        }) { (data, response, err) in
        }
    }
    
    @objc func switchToPoints() {
        let pointsViewController = PointsViewController()
        self.navigationController?.pushViewController(pointsViewController, animated: true)

    }
    
}
