//
//  ViewController.swift
//  Sound Board
//
//  Created by qamarali on 6/18/17.
//  Copyright © 2017 qamarali. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var audioPlayer : AVAudioPlayer?
    
    var soundList : [Sound] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            soundList = try context.fetch(Sound.fetchRequest())
            tableView.reloadData()
        } catch {
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soundList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let sound = soundList[indexPath.row]
        cell.textLabel?.text = sound.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       let sound = soundList[indexPath.row]
       
        do {
            
        audioPlayer = try AVAudioPlayer(data: sound.audio! as Data)
        audioPlayer?.play()
            
            
        } catch {
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
             let sound = soundList[indexPath.row]
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(sound)
         (UIApplication.shared.delegate as! AppDelegate).saveContext()
             tableView.reloadData()

        }
    }
    
}

