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
    
    let playImg = PImageView(imgName: "play")
    let answerImg = PImageView(imgName: "record")
    
    let playButton = PButton(text: "Play the clip", titleColor: Colors.base, backgroundColor: UIColor.white, hasBorder: false)
    let answerButton = PButton(text: "Answer", titleColor: Colors.base, backgroundColor: UIColor.white, hasBorder: false)
    
    let speechRecognizer = SFSpeechRecognizer()
    var recognitionRequest:SFSpeechURLRecognitionRequest!
    var audioSession:AVAudioSession!
    var audioRecorder:AVAudioRecorder!
    var audioPlayer:AVAudioPlayer!
    
    var bestResult = ""
    
    let responseText = PLabel(font: UIFont.systemFont(ofSize: 16.0), text: "", alignment: .center, textColor: Colors.base)
    
    init(question: String, key: String, index: Int) {
        self.question = question
        self.key = key
        self.index = index
        super.init(nibName: nil, bundle: nil)
        
        self.title = "\(key) - Educational Study"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.audioSession = AVAudioSession.sharedInstance()
        do {
            try self.audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: .spokenAudio, options: .defaultToSpeaker)
            try self.audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch let error{
            print("audioSession properties weren't set because of an error: ", error)
        }
        
        self.playButton.addTarget(self, action: #selector(QuestionViewController.playQuestion), for: .touchUpInside)
        self.answerButton.addTarget(self, action: #selector(QuestionViewController.recordTapped), for: .touchUpInside)
        self.view.backgroundColor = UIColor.white
        
        self.requestSpeechAuthorization()
        
        self.view.addSubview(self.playImg)
        self.view.addSubview(self.answerImg)
        self.view.addSubview(self.playButton)
        self.view.addSubview(self.answerButton)
        self.view.addSubview(self.responseText)
        addConstraints()
    }
    
    func addConstraints() {
        self.view.addConstraints(PConstraint.squareWidthConstraints(view: self.playImg, squareRatio: 0.3))
        self.view.addConstraint(PConstraint.horizontalAlignConstraint(firstView: self.playImg, secondView: self.view))
        self.view.addConstraint(PConstraint.paddingPositionConstraint(view: self.playImg, side: .top, padding: 240))
        
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.playImg, lowerView: self.playButton, spacing: 20))
        self.view.addConstraint(PConstraint.horizontalAlignConstraint(firstView: self.playImg, secondView: self.playButton))
        
        self.view.addConstraints(PConstraint.squareWidthConstraints(view: self.answerImg, squareRatio: 0.3))
        self.view.addConstraint(PConstraint.horizontalAlignConstraint(firstView: self.answerImg, secondView: self.view))
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.playButton, lowerView: self.answerImg, spacing: 60))

        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.answerImg, lowerView: self.answerButton, spacing: 20))
        self.view.addConstraint(PConstraint.horizontalAlignConstraint(firstView: self.answerImg, secondView: self.answerButton))
        
        self.view.addConstraints(PConstraint.paddingPositionConstraints(view: self.responseText, sides: [.left, .right], padding: 40))
        self.view.addConstraint(PConstraint.verticalSpacingConstraint(upperView: self.answerButton, lowerView: self.responseText, spacing: 25))
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
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    @objc func recordTapped() {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
            let url = getDocumentsDirectory().appendingPathComponent("recording.m4a")
            transcribeAudio(url: url)
        }
    }
    
    @objc func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            self.audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            self.audioRecorder.delegate = self
            self.audioRecorder.prepareToRecord()
            self.audioRecorder.record()

            self.answerButton.setTitle("Finish Answering", for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        self.audioRecorder.stop()
        self.audioRecorder = nil

        if success {
            self.answerButton.setTitle("Re-Answer", for: .normal)
            let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
            transcribeAudio(url: audioFilename)
        } else {
            self.answerButton.setTitle("Answer", for: .normal)
            // recording failed :(
        }
    }
    
    func transcribeAudio(url: URL) {
        // create a new recognizer and point it at our audio
        self.recognitionRequest = SFSpeechURLRecognitionRequest(url: url)
        
        // start recognition!
        self.speechRecognizer?.recognitionTask(with: self.recognitionRequest, resultHandler: { result, error in
            if let result = result {
                if result.isFinal {
                    self.bestResult = result.bestTranscription.formattedString
                    let params:[String: String] = [
                        "question": self.question,
                        "answer": self.bestResult
                    ]
                    
                    DispatchQueue.main.async {
                        self.responseText.text = self.bestResult
                    }
                    
                    HTTPAPI.instance().call(url: URLS.similarity, params: params, method: .POST, success: { (data, response, err) in
                        let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String: Double]
                        let similarity = (json!["similarity"])!

                        DispatchQueue.main.async {
                            if similarity < 0.2 {
                                let alert = UIAlertController(title: "Assessing Understanding", message: "Sorry, it looks like you don't completely understand the information yet. Your score is \(similarity). Try again?", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            } else {
                                let alert = UIAlertController(title: "Assessing Understanding", message: "Awesome! It looks like you really understand the information. Your score is \(similarity).", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }) { (data, response, err) in
                    }
                }
            } else {
                print(error)
            }
        })
    }
        
    func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
        }
    }
    
}

extension QuestionViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}
