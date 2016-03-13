//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Seraph on 3/13/16.
//  Copyright © 2016 Seraphim. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operator: String {
        case Multiply = "*"
        case Divide = "/"
        case Subtract = "-"
        case Add = "+"
        case None = "none"
    }
    
    @IBOutlet weak var outputLabel: UILabel!
    var buttonSound: AVAudioPlayer!
    
    var calculatedValue = 0.0
    var currentValue = ""
    var currentOperator = Operator.None
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try buttonSound = AVAudioPlayer(contentsOfURL: soundUrl)
            buttonSound.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    @IBAction func numberPresses(sender: UIButton!) {
        playSound()
        currentValue += "\(sender.tag)"
        outputLabel.text = currentValue
    }
    
    @IBAction func onEqualPressed(sender: UIButton!) {
        Calculate(currentOperator)
        resetCalculation()
    }
    
    @IBAction func onSubstractPressed(sender: UIButton!) {
        Calculate(Operator.Subtract)
    }
    
    @IBAction func onMultiplyPresses(sender: UIButton!) {
        Calculate(Operator.Multiply)
    }
    @IBAction func onAddPressed(sender: UIButton!) {
        Calculate(Operator.Add)
    }
    
    @IBAction func onDividePressed(sender: UIButton!) {
        Calculate(Operator.Divide)
    }
    
    @IBAction func onClearPressed(sender: UIButton!) {
        playSound()
        outputLabel.text = "0.0"
        resetCalculation()
    }
    
    func Calculate(operat: Operator) {
        playSound()
        
        if currentValue != "" {
            if currentOperator != Operator.None {
                
                if currentOperator == Operator.Add {
                    calculatedValue = calculatedValue + Double(currentValue)!
                } else if currentOperator == Operator.Subtract {
                    calculatedValue = calculatedValue - Double(currentValue)!
                } else if currentOperator == Operator.Multiply {
                    calculatedValue = calculatedValue * Double(currentValue)!
                } else if currentOperator == Operator.Divide {
                    if Double(currentValue)! != 0 {
                        calculatedValue = calculatedValue / Double(currentValue)!
                    }
                }
                
                outputLabel.text = String(calculatedValue)
                
            } else {
                calculatedValue = Double(currentValue)!
            }
        }
        
        currentValue = ""
        currentOperator = operat
    }
    
    func playSound() {
        if buttonSound.playing {
            buttonSound.stop()
        }
        
        buttonSound.play()
    }
    
    func resetCalculation() {
        currentValue = ""
        calculatedValue = 0.0
        currentOperator = Operator.None
    }
}

