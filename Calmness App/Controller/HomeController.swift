//
//  HomeController.swift
//  Calmness App
//
//  Created by Ricky Erdiansyah on 13/05/19.
//  Copyright © 2019 Ricky Erdiansyah. All rights reserved.
//

import UIKit
import AVFoundation // Audio Visual
import MediaPlayer

class HomeController: UIViewController {

    var audioPlayer = AVAudioPlayer()
    var isPlaying = false
    
    @IBOutlet weak var playOutlet: UIButton!
    @IBAction func playBtn(_ sender: UIButton) {
        if isPlaying == false{
            audioPlayer.play()
            isPlaying = true
        }else if isPlaying == true{
            audioPlayer.pause()
            isPlaying = false
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSound()
        // mediaPlayer()
        playOutlet.layer.borderColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        playOutlet.layer.borderWidth = 1
        playOutlet.layer.cornerRadius = 10
        // imageItem.layer.
    }
    
    func addSound(){
        let sound = Bundle.main.path(forResource: "Coldplay", ofType: "m4a")
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        }catch{
            print(error)
        }
    }
  
    func mediaPlayer(){
        let myMediaPlayer = MPMusicPlayerController.applicationQueuePlayer
        
        myMediaPlayer.setQueue(with: MPMediaQuery.songs())
        
        myMediaPlayer.play()
    }

}
