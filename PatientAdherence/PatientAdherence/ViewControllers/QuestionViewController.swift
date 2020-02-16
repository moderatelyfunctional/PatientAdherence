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
    
//    let audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer()
    var recognitionRequest:SFSpeechURLRecognitionRequest!
    var audioSession:AVAudioSession!
    var audioRecorder:AVAudioRecorder!
    var audioPlayer:AVAudioPlayer!
    
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
        let url = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        transcribeAudio(url: url)
        return
        
        
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        print(audioFilename)
        
        do {
            try self.audioPlayer = AVAudioPlayer(contentsOf: audioFilename)
            self.audioPlayer.play()
        } catch {
            print("some error")
        }
        return
        
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
//            let url = getDocumentsDirectory().appendingPathComponent("recording.m4a")
//            transcribeAudio(url: url)
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
            self.audioRecorder.record(forDuration: 10)
//            self.audioRecorder.record()

            self.answerButton.setTitle("Finish Answering", for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        self.audioRecorder.stop()
        self.audioRecorder = nil

        if success {
            self.answerButton.setTitle("Start Re-Answering", for: .normal)
        } else {
            self.answerButton.setTitle("Start Answering", for: .normal)
            // recording failed :(
        }
    }
    
    func transcribeAudio(url: URL) {
        // create a new recognizer and point it at our audio
        self.recognitionRequest = SFSpeechURLRecognitionRequest(url: url)
        self.recognitionRequest.shouldReportPartialResults = true
        
        // start recognition!
        self.speechRecognizer?.recognitionTask(with: self.recognitionRequest, resultHandler: { result, error in
            if let result = result {
                self.bestResult = result.bestTranscription.formattedString
                print(self.bestResult)
//                if result.isFinal {
//                    print(result.bestTranscription.formattedString)
//                }
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
