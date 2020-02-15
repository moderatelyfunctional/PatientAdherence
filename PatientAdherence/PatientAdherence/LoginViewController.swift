//
//  LoginViewController.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/15/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.green
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let url = "https://postman-echo.com/post"
        let params:[String: Any] = [
            "foo":1,
            "so": 2
        ]
        
        HTTPAPI.instance().call(url: url, params: params, method: .POST, success: { (data, response, err) in
            print("DATA IS \(data)")
            print("JSON String: \(String(data: data, encoding: .utf8)!)")

        }) { (data, response, err) in
            print("error")
        }
    }
    

}

