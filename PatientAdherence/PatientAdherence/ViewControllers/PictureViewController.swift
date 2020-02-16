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
        
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.takePicture)
        self.view.addSubview(self.submitButton)
        addConstraints()
    }
    
    func addConstraints() {
        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.titleLabel, sides: [.left, .right], padding: 60))
        self.view.addConstraint(PConstraint.paddingPositionConstraint(view: self.titleLabel, side: .top, padding: 100))
        
//        self.view.addConstraints(PConstraint.centerAlignConstraints(firstView: self.takePicture, secondView: self.view))
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.titleLabel, lowerView: self.takePicture, spacing: 50))
        self.view.addConstraints(PConstraint.squareWidthConstraints(view: self.takePicture, squareRatio: 0.6))
        self.view.addConstraint(PConstraint.horizontalAlignConstraint(firstView: self.takePicture, secondView: self.view))
        
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.takePicture, lowerView: self.submitButton, spacing: 50))
        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.submitButton, sides: [.left, .right], padding: 60))
        self.view.addConstraint(PConstraint.fillYConstraints(view: self.submitButton, heightRatio: 0.08))
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
