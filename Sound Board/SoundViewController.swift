//
//  SoundViewController.swift
//  Sound Board
//
//  Created by Dylan Grozdanich on 1/23/17.
//  Copyright © 2017 Dylan Grozdanich. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var textField: UITextField!
    
    
    var audioRecorder : AVAudioRecorder? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    func setupRecorder () {
        do {
        // Create an audio session
        let session = AVAudioSession.sharedInstance()
        try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try session.overrideOutputAudioPort(.speaker)
        try session.setActive(true)
        
        // Create URL for the audio file
        
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            
            let pathComponents = [basePath, "audio.m4a"]
            
            let audioURL = NSURL.fileURL(withPathComponents: pathComponents)
            
        // Create settings for the audio recordered
        
            var settings : [String:AnyObject] = [:]
             settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject?
            settings[AVSampleRateKey] = 44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey] = 2 as AnyObject?
            
            
        // Create AudioRecorder object
        
        audioRecorder = try AVAudioRecorder(url: audioURL!, settings: settings)
            
            audioRecorder!.prepareToRecord()
            
        } catch let error as NSError {
            print(error)
                
        }
        
    }
    
    
    @IBAction func recordTapped(_ sender: Any) {
    }

    @IBAction func playTapped(_ sender: Any) {
    }
    
    @IBAction func addTapped(_ sender: Any) {
    }
    
    
}
