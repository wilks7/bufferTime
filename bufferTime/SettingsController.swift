//
//  SettingsController.swift
//  bufferTime
//
//  Created by Michael Wilkowski on 1/11/16.
//  Copyright © 2016 JustWilks. All rights reserved.
//

import UIKit
import AVFoundation

class SettingsController {

    static let sharedController = SettingsController()
    
    var bombSoundEffect: AVAudioPlayer!
    
    func checkNS()->Bool{
        
        guard let _ = NSUserDefaults.standardUserDefaults().valueForKey("allSettings") else {return false}
        return true
    }
    
    func playSound(){
        
//
//        let path = NSBundle.mainBundle().pathForResource("MGS", ofType:"mp3")!
//        let url = NSURL(fileURLWithPath: path)
//        
//        do {
//            let sound = try AVAudioPlayer(contentsOfURL: url)
//            bombSoundEffect = sound
//            sound.prepareToPlay()
//            sound.play()
//        } catch {
//            // couldn't load file :(
//        }
        let path = NSBundle.mainBundle().pathForResource("MGS.mp3", ofType:nil)!
        let url = NSURL(fileURLWithPath: path)
        let sound = try! AVAudioPlayer(contentsOfURL: url)
        bombSoundEffect = sound
        sound.play()
    }
    
}
