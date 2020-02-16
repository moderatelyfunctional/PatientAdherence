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
        text: "Placeholder",
        alignment: .center,
        textColor: UIColor.white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = Colors.baseColor
        self.view.addSubview(self.titleLabel)
        
        addConstraints()
    }

    func addConstraints() {
        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.titleLabel, sides: [.left, .right], padding: 60))
        self.view.addConstraint(PConstraint.paddingPositionConstraint(view: self.titleLabel, side: .top, padding: 100))
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
    

}

