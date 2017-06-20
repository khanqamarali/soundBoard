//
//  soundViewController.swift
//  Sound Board
//
//  Created by qamarali on 6/20/17.
//  Copyright © 2017 qamarali. All rights reserved.
//

import UIKit
import AVFoundation

class soundViewController: UIViewController {
    
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    var audioRecorder : AVAudioRecorder?
    var audioPlayer : AVAudioPlayer?
    var audioURL : URL?
    @IBOutlet weak var playButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAudio()
        
        playButton.isEnabled = false
    }
    
    func setupAudio()
    {
        
        do
        {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponent = [basePath,"audio.m4a"]
            
            audioURL = NSURL.fileURL(withPathComponents: pathComponent)!
            
            var settings : [String:AnyObject] = [:]
            
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject
            
            settings[AVSampleRateKey] = 44100.0 as AnyObject
            
            settings[AVNumberOfChannelsKey] = 2 as AnyObject
            
            audioRecorder = try AVAudioRecorder(url: audioURL!, settings: settings)
            audioRecorder?.prepareToRecord()
            
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    @IBAction func tappedRecord(_ sender: Any) {
        if audioRecorder!.isRecording {
            
            audioRecorder?.stop()
            recordButton.setTitle("Record", for: .normal)
            playButton.isEnabled = true

            
        } else {
            audioRecorder?.record()
            
            recordButton.setTitle("Stop", for: .normal)
            
        }

        
    }
    @IBAction func tappedPlay(_ sender: Any) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:audioURL!)
            audioPlayer?.play()

        } catch {}
            }
    
    @IBAction func tappedAdd(_ sender: Any) {
        
        
        
    }
    
}
