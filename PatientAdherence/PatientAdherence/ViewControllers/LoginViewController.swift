//
//  LoginViewController.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/15/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    let titleLabel = PLabel(
        font: UIFont.systemFont(ofSize: 40.0),
        text: "Glucose Guardian",
        alignment: .left,
        textColor: UIColor.white)
    let emailField = PTextField(color: UIColor.white, placeholderText: "email address")
    let passwordField = PTextField(color: UIColor.white, placeholderText: "password")
    let loginButton = PButton(text: "Login", titleColor: UIColor.white, backgroundColor: UIColor.clear, hasBorder: true)
    let switchButton = PButton(text: "No account? Sign up here.", titleColor: UIColor.white, backgroundColor: UIColor.clear, hasBorder: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.switchButton.addTarget(self, action: #selector(LoginViewController.switchToSignUp), for: .touchUpInside)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard)))
        
        self.view.backgroundColor = Colors.baseColor
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.emailField)
        self.view.addSubview(self.passwordField)
        self.view.addSubview(self.loginButton)
        self.view.addSubview(self.switchButton)
        addConstraints()
    }

    func addConstraints() {
        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.titleLabel, sides: [.left, .right], padding: 60))
        self.view.addConstraint(PConstraint.paddingPositionConstraint(view: self.titleLabel, side: .top, padding: 100))
        
        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.emailField, sides: [.left, .right], padding: 60))
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.titleLabel, lowerView: self.emailField, spacing: 60))
        self.view.addConstraint(PConstraint.fillYConstraints(view: self.emailField, heightRatio: 0.08))
        
        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.passwordField, sides: [.left, .right], padding: 60))
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.emailField, lowerView: self.passwordField, spacing: 10))
        self.view.addConstraint(PConstraint.fillYConstraints(view: self.passwordField, heightRatio: 0.08))
        
        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.loginButton, sides: [.left, .right], padding: 60))
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.passwordField, lowerView: self.loginButton, spacing: 100))
        self.view.addConstraint(PConstraint.fillYConstraints(view: self.loginButton, heightRatio: 0.085))

        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.switchButton, sides: [.left, .right], padding: 60))
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.loginButton, lowerView: self.switchButton, spacing: 10))
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
    
    @objc func switchToSignUp() {
        let signUpViewController = SignupViewController()
        signUpViewController.modalPresentationStyle = .fullScreen
        self.present(signUpViewController, animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    

}

