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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAudio()
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
            
            let audiURL = NSURL.fileURL(withPathComponents: pathComponent)!
            
            var settings : [String:AnyObject] = [:]
            
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject
            
            settings[AVSampleRateKey] = 44100.0 as AnyObject
            
            settings[AVNumberOfChannelsKey] = 2 as AnyObject
            
             audioRecorder = try AVAudioRecorder(url: audiURL, settings: settings)
             audioRecorder?.prepareToRecord()
            
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    @IBAction func tappedPlay(_ sender: Any) {
    }
    
    @IBAction func tappedAdd(_ sender: Any) {
    }
    
   }
