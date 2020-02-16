//
//  SignupViewController.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/15/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    let titleLabel = PLabel(
        font: UIFont.systemFont(ofSize: 40.0),
        text: "Glucose Guardian",
        alignment: .left,
        textColor: Colors.baseColor)
    let nameField = PTextField(color: Colors.baseColor, placeholderText: "name")
    let emailField = PTextField(color: Colors.baseColor, placeholderText: "email address")
    let passwordField = PTextField(color: Colors.baseColor, placeholderText: "password")
    let signupButton = PButton(text: "Sign up", titleColor: UIColor.white, backgroundColor: Colors.baseColor, hasBorder: true)
    let switchButton = PButton(text: "Have an account? Login here.", titleColor: Colors.baseColor, backgroundColor: UIColor.clear, hasBorder: false)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.signupButton.addTarget(self, action: #selector(SignupViewController.switchToPicture), for: .touchUpInside)
        self.switchButton.addTarget(self, action: #selector(SignupViewController.switchToLogin), for: .touchUpInside)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard)))

        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.nameField)
        self.view.addSubview(self.emailField)
        self.view.addSubview(self.passwordField)
        self.view.addSubview(self.signupButton)
        self.view.addSubview(self.switchButton)
        addConstraints()
    }

    func addConstraints() {
        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.titleLabel, sides: [.left, .right], padding: 60))
        self.view.addConstraint(PConstraint.paddingPositionConstraint(view: self.titleLabel, side: .top, padding: 100))
        
        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.nameField, sides: [.left, .right], padding: 60))
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.titleLabel, lowerView: self.nameField, spacing: 30))
        self.view.addConstraint(PConstraint.fillYConstraints(view: self.nameField, heightRatio: 0.08))
        
        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.emailField, sides: [.left, .right], padding: 60))
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.nameField, lowerView: self.emailField, spacing: 10))
        self.view.addConstraint(PConstraint.fillYConstraints(view: self.emailField, heightRatio: 0.08))
        
        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.passwordField, sides: [.left, .right], padding: 60))
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.emailField, lowerView: self.passwordField, spacing: 10))
        self.view.addConstraint(PConstraint.fillYConstraints(view: self.passwordField, heightRatio: 0.08))
        
        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.signupButton, sides: [.left, .right], padding: 60))
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.passwordField, lowerView: self.signupButton, spacing: 70))
        self.view.addConstraint(PConstraint.fillYConstraints(view: self.signupButton, heightRatio: 0.085))

        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.switchButton, sides: [.left, .right], padding: 60))
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.signupButton, lowerView: self.switchButton, spacing: 10))
        self.view.addConstraint(PConstraint.fillYConstraints(view: self.switchButton, heightRatio: 0.05))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let url = "https://postman-echo.com/post"
        let params:[String: Any] = [
            "foo":1,
            "so": 2
        ]
    //        HTTPAPI.instance().call(url: url, params: params, method: .POST, success: { (data, response, err) in
    //            print("DATA IS \(data)")
    //            print("JSON String: \(String(data: data, encoding: .utf8)!)")
    //
    //        }) { (data, response, err) in
    //            print("error")
    //        }
    }

    @objc func switchToLogin() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func switchToPicture() {
//        let name = self.nameField.text
        let name = "Jing"
        let pictureViewController = PictureViewController(name: name)
        pictureViewController.modalPresentationStyle = .fullScreen
        self.present(pictureViewController, animated: true, completion: nil)
    }
    
    
}
