//
//  PictureViewController.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/15/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController {
    
    var imagePicker: UIImagePickerController!
    
    let titleLabel = PLabel(
        font: UIFont.systemFont(ofSize: 40.0),
        text: "Hi! Create your account here.",
        alignment: .left,
        textColor: UIColor.white)
    let takePicture = TakePicture()
    let submitButton = PButton(text: "Submit", titleColor: UIColor.white, backgroundColor: UIColor.clear, hasBorder: true)

    init(name: String) {
        self.titleLabel.text = "Hi \(name), take a photo!"
        super.init(nibName: nil, bundle: nil)
                
        self.view.backgroundColor = Colors.base
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.takePicture.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PictureViewController.takePhoto)))
        
        self.submitButton.addTarget(self, action: #selector(switchToQuestions), for: .touchUpInside)
        
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.takePicture)
        self.view.addSubview(self.submitButton)
        addConstraints()
    }
    
    func addConstraints() {
        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.titleLabel, sides: [.left, .right], padding: 60))
        self.view.addConstraint(PConstraint.paddingPositionConstraint(view: self.titleLabel, side: .top, padding: 100))
        
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.titleLabel, lowerView: self.takePicture, spacing: 50))
        self.view.addConstraints(PConstraint.squareWidthConstraints(view: self.takePicture, squareRatio: 0.6))
        self.view.addConstraint(PConstraint.horizontalAlignConstraint(firstView: self.takePicture, secondView: self.view))
        
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.takePicture, lowerView: self.submitButton, spacing: 50))
        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.submitButton, sides: [.left, .right], padding: 60))
        self.view.addConstraint(PConstraint.fillYConstraints(view: self.submitButton, heightRatio: 0.08))
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
            
            let key = elementSubelement[0].components(separatedBy: "_").joined(separator: " ")
            
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
        print(dataElements)
        print(headers)
        
        FakeData.headers = headers
        FakeData.diabetes = dataElements
        FakeData.diabetesProgress = dataProgress
    }
    
    @objc func switchToQuestions() {

        HTTPAPI.instance().call(url: URLS.diabetes, params: nil, method: .GET, success: { (data, response, err) in
            let stringData = String(data: data, encoding: .utf8)!
            self.processDiabetesData(stringData: stringData)
            
            DispatchQueue.main.async {
                let questionsViewController = UINavigationController(rootViewController: QuestionsListViewController())
                questionsViewController.modalPresentationStyle = .fullScreen
                self.present(questionsViewController, animated: true, completion: nil)
            }
        }) { (data, response, err) in
        }
    }
}

extension PictureViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @objc func takePhoto() {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
}
