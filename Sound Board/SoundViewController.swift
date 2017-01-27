//
//  SoundViewController.swift
//  Sound Board
//
//  Created by Dylan Grozdanich on 1/23/17.
//  Copyright © 2017 Dylan Grozdanich. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var addButton: UIButton!
    
    var audioRecorder : AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    var audioURL : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setupRecorder()
        playButton.isEnabled = false
        addButton.isEnabled = false
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
            
            audioURL = NSURL.fileURL(withPathComponents: pathComponents)
            print("########################")
            print(audioURL!)
            print("#########################")
            
        // Create settings for the audio recordered
        
            var settings : [String:AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject?
            settings[AVSampleRateKey] = 44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey] = 2 as AnyObject?
            
            
        // Create AudioRecorder object
        
        audioRecorder = try AVAudioRecorder(url: audioURL!, settings: settings)
            
            audioRecorder.prepareToRecord()
            
        } catch let error as NSError {
            print(error)
                
        }
        
    }
    
    
    @IBAction func recordTapped(_ sender: Any) {
        
        if audioRecorder.isRecording {
            // Stop the Recording
            audioRecorder.stop()
            // Change button title to record
            recordButton.setTitle("Record", for: .normal)
            
            playButton.isEnabled = true
            
            addButton.isEnabled = true
            
        } else {
            // Start the Recording
            audioRecorder.record()
            
            // Change button title to stop
            recordButton.setTitle("Stop", for: .normal)
            
        }
        
    }

    @IBAction func playTapped(_ sender: Any) {
        do {
            
       try audioPlayer = AVAudioPlayer(contentsOf: audioURL!)
            audioPlayer!.play()
        } catch {}
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        

        let sound = Sound(context: context)
        sound.name = textField.text
        sound.audio = NSData(contentsOf: audioURL!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
    
    
}
