//
//  Constants.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/15/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit

struct Colors {
    static let base = UIColor(red: 84.0/255, green: 160.0/255, blue: 104.0/255, alpha: 1.0)
    static let grey = UIColor(red: 120.0/255, green: 120.0/255, blue: 120.0/255, alpha: 1.0)
    static let red = UIColor(red: 235.0/255, green: 110.0/255, blue: 124.0/255, alpha: 1.0)
    static let yellow = UIColor(red: 250.0/255, green: 215.0/255, blue: 117.0/255, alpha: 1.0)
}

struct URLS {
    static let diabetes = "https://treehacksapp-conditions.s3.amazonaws.com/condition-kb.txt"
    static let similarity = "http://3.82.250.203/similarity"
}

struct FakeData {
    static var headers:[String] = ["symptoms", "causes", "treatments"]
    static var diabetes:[String:[String]] = [
        "symptoms": ["how are you today", "b", "c", "d", "e"],
        "causes": ["b", "d", "e", "f"],
        "treatments": ["a", "b"]
    ]
    static var diabetesProgress:[String:[Int]] = [
        "symptoms": [0, 0, 0, 0, 0],
        "causes": [0, 0, 0, 0],
        "treatments": [0, 0]
    ]
}
