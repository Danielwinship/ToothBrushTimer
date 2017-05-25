//
//  ViewController.swift
//  ToothBrushTimer
//
//  Created by Daniel Winship on 5/24/17.
//  Copyright © 2017 Daniel Winship. All rights reserved.
//

import UIKit
import  AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var timerButtonLabel: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    let startingTime = "120"
    var seconds = 120
    var timer = Timer()
    var isTimerRunning = false
    var player : AVAudioPlayer?
    
    func playSuccessSound() {
        let url2 = Bundle.main.url(forResource: "TimerOver", withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url2)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }

    
    
    
    func playBackgroundSound() {
    let url = Bundle.main.url(forResource: "BrushingSong", withExtension: "mp3")!
    
    do {
    player = try AVAudioPlayer(contentsOf: url)
    guard let player = player else { return }
    
    player.prepareToPlay()
    player.play()
    } catch let error as NSError {
    print(error.description)
    }
    }
    
    @IBAction func timerButton(_ sender: Any) {
        if isTimerRunning == false {
            playBackgroundSound()
            runTimer()
            
            
        }else
        {
           stopAndResetTimer()
           player?.stop()
           
        }
        
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
        self.timerButtonLabel.setTitle("Stop/Reset", for: .normal)
    }
    
    func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            timerLabel.text = "You did it!"
            player?.stop()
            playSuccessSound()
            
           
        } else {
            seconds -= 1
            timerLabel.text = "\(seconds)"
        }
    }
    
    func stopAndResetTimer() {
        timer.invalidate()
        seconds = 120
        timerLabel.text = startingTime
        self.timerButtonLabel.setTitle("Start", for: .normal)
        isTimerRunning = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.text = startingTime
        UIApplication.shared.isIdleTimerDisabled = true

    }
    override func viewDidDisappear(_ animated: Bool) {
        UIApplication.shared.isIdleTimerDisabled = false
    }

   


}

