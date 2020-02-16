//
//  QuestionViewController.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/16/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class QuestionViewController: UIViewController {
    
    let question:String
    let key:String
    let index:Int
    
    let playButton = PButton(text: "Play", titleColor: UIColor.white, backgroundColor: Colors.base, hasBorder: true)
    let answerButton = PButton(text: "Answer", titleColor: UIColor.white, backgroundColor: Colors.base, hasBorder: true)
    
    var audioSession:AVAudioSession!
    let audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer()
    var recognitionTask:SFSpeechRecognitionTask?
    var recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

    
    var bestResult = ""
//    let request = SFSpeechAudioBufferRecognitionRequest()
//    var recognitionTask:SFSpeechRecognitionTask?
    
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
        
        var audioSession: AVAudioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: .spokenAudio, options: .defaultToSpeaker)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch let error{
            print("audioSession properties weren't set because of an error: ", error)
        }
        
        self.playButton.addTarget(self, action: #selector(QuestionViewController.playQuestion), for: .touchUpInside)
        self.answerButton.addTarget(self, action: #selector(QuestionViewController.recordAnswer), for: .touchUpInside)
        self.view.backgroundColor = UIColor.white
        
        self.requestSpeechAuthorization()
        
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
        self.audioSession = AVAudioSession.sharedInstance()
        do {
            try self.audioSession.setCategory(.playAndRecord, options: .defaultToSpeaker)
            try self.audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            self.audioSession.requestRecordPermission { allowed in
            }
        } catch {
        }
        
        let utterance = AVSpeechUtterance(string: self.question)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    @objc func recordAnswer() {
        
    }
        
    @objc func answerTapped() {
        if self.audioEngine.isRunning {
            self.audioEngine.stop()
            self.audioEngine.inputNode.removeTap(onBus: 0)
            self.recognitionRequest.endAudio()
            self.recognitionTask?.cancel()
            self.answerButton.setTitle("Start Answering", for: .normal)
            print("BEST RESULT IS \(self.bestResult)")
        } else {
            recordAndRecognizeSpeech()
            self.answerButton.setTitle("Finish Answering", for: .normal)
        }
    }
    
    func recordAndRecognizeSpeech() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.record)
            try audioSession.setMode(.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }

        let node = self.audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.recognitionRequest.append(buffer)
        }
        self.audioEngine.prepare()
        do {
            try self.audioEngine.start()
        } catch {
            return print(error)
        }
        guard let recognizer = SFSpeechRecognizer() else {
            return
        }
        if !recognizer.isAvailable {
            return
        }
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { result, error in
            if result != nil {
                if let result = result {
                    let bestString = result.bestTranscription.formattedString
                    print(bestString)
                } else if let error = error {
                    print(error)
                }
            }
        })
    }
    
    func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
        }
    }
    
}

extension QuestionViewController: SFSpeechRecognizerDelegate {
    
    
    
}
