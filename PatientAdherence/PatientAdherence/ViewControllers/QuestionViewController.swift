//
//  QuestionViewController.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/16/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit
import AVFoundation

class QuestionViewController: UIViewController {
    
    let question:String
    let key:String
    let index:Int
    
    let playButton = PButton(text: "Play", titleColor: UIColor.white, backgroundColor: Colors.base, hasBorder: true)
    let answerButton = PButton(text: "Answer", titleColor: UIColor.white, backgroundColor: Colors.base, hasBorder: true)
    
    var recordingSession:AVAudioSession!
    
    init(question: String, key: String, index: Int) {
        self.question = question
        self.key = key
        self.index = index
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playButton.addTarget(self, action: #selector(QuestionViewController.playQuestion), for: .touchUpInside)
        self.answerButton.addTarget(self, action: #selector(QuestionViewController.answerQuestion), for: .touchUpInside)
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.playButton)
        self.view.addSubview(self.answerButton)
        addConstraints()
    }
    
    func addConstraints() {
        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.playButton, sides: [.left, .top, .right], padding: 20))
        self.view.addConstraint(PConstraint.fillYConstraints(view: self.playButton, heightRatio: 0.2))
        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.answerButton, sides: [.left, .bottom, .right], padding: 20))
        self.view.addConstraint(PConstraint.fillYConstraints(view: self.answerButton, heightRatio: 0.2))
        
    }
    
    @objc func playQuestion() {
        self.recordingSession = AVAudioSession.sharedInstance()
        do {
            try self.recordingSession.setCategory(.playAndRecord, options: .defaultToSpeaker)
            try self.recordingSession.setActive(true, options: .notifyOthersOnDeactivation)
            self.recordingSession.requestRecordPermission { allowed in
            }
        } catch {
        }
        
        let utterance = AVSpeechUtterance(string: self.question)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    @objc func answerQuestion() {
        
    }
    
}
