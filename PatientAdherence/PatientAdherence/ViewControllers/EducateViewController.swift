//
//  EducateViewController.swift
//  PatientAdherence
//
//  Created by Jing Lin on 2/15/20.
//  Copyright © 2020 Jing Lin. All rights reserved.
//

import UIKit
import AVFoundation

class EducateViewController: UIViewController {
    
    let recordButton = PButton(
        text: "Press To Answer",
        titleColor: UIColor.white,
        backgroundColor: UIColor.green)
    var recordingSession:AVAudioSession!
    var audioRecorder:AVAudioRecorder!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.recordButton.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
        
        self.view.addSubview(self.recordButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.recordingSession = AVAudioSession.sharedInstance()
        do {
            try self.recordingSession.setCategory(.playAndRecord, options: .defaultToSpeaker)
            try self.recordingSession.setActive(true, options: .notifyOthersOnDeactivation)
            self.recordingSession.requestRecordPermission { allowed in
            }
        } catch {
        }
    }
    
    func startRecording() {
        var audioFilename = getAudioDirectory().appendingPathComponent("curr_recording.m4a")
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            self.audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            self.audioRecorder.delegate = self
            self.audioRecorder.record()
            
            self.recordButton.setTitle("Press To Stop", for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    
    func getAudioDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func finishRecording(success: Bool) {
        self.audioRecorder.stop()
        self.audioRecorder = nil
        
        recordButton.setTitle("Press To Answer", for: .normal)
    }
    
    @objc func recordTapped() {
        if self.audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
}

extension EducateViewController: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
}
