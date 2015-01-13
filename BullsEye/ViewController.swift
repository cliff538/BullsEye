//
//  ViewController.swift
//  BullsEye
//
//  Created by Cliff Gurske on 12/11/14.
//  Copyright (c) 2014 cliff538. All rights reserved.
//

import UIKit
import QuartzCore // Core Animation


class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider! // This allows IB to see the var slider.
    @IBOutlet weak var targetLabel: UILabel!
		@IBOutlet weak var scoreLabel: UILabel!
		@IBOutlet weak var roundLabel: UILabel!
	
	
    // Global Variables:
    var currentValue: Int = 0 // You can add the var type Int if you want, but like the score var you don't have to. It will be infered.
    var targetValue: Int = 0
		var score = 0
		var round = 0

    override func viewDidLoad() { // This stuff only happens once when you start the App.
        super.viewDidLoad()
        startNewGame()
				updateLabels()
			
			let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
			slider.setThumbImage(thumbImageNormal, forState: .Normal)
			
			let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
			slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted)
			
			let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
			
			if let trackLeftImage = UIImage(named: "SliderTrackLeft") {
				let trackLeftResizable =
				trackLeftImage.resizableImageWithCapInsets(insets); slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
			}
			
			if let trackRightImage = UIImage(named: "SliderTrackRight") {
				let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
				slider.setMaximumTrackImage(trackRightResizable, forState: .Normal) }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Objects:
    @IBAction func showAlert() {
			
				let difference = abs(targetValue - currentValue) // abs() turns any negative value into a positive. Much easier than, for example: if difference < 0 { difference = difference * -1 } (short-hand: difference *= -1)
			
				var points = 100 - difference
			
				var title: String
				if difference == 0 {
						title = "Perfect!"
						points += 100
				} else if difference < 5 {
						title = "You almost had it!"
					if difference == 1 {
						points += 50
					}
				} else if difference < 10 {
						title = "Pretty Good"
				} else {
						title = "Not even close... Try again!"
				}
			
				score += points  // This is the same as: score = score + points
			
        let message = "You placed the slider at: \(currentValue)" + "\n The target value was: \(targetValue)" + "\n You scored \(points) points!"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
				let action = UIAlertAction(title: "OK", style: .Default, handler: { action in
				
																																						self.startNewRound()  // This block of code under handler: is called a closure.
																																						self.updateLabels()
																																				})
				
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
        
			
    }
    
    @IBAction func sliderMoved(slider: UISlider) {  // slider is a parameter that takes info from UISlider
        
        currentValue = lroundf(slider.value)
        println("The value of the slider is now: \(slider.value)")
        println(currentValue)
    }
	
		@IBAction func startOver() {
				startNewGame()
				updateLabels()
			
			// This is all the Core Animation stuff brought in from import QuartzCore
				let transition = CATransition()
				transition.type = kCATransitionFade
				transition.duration = 1
				transition.timingFunction = CAMediaTimingFunction(name:
					kCAMediaTimingFunctionEaseOut)
					view.layer.addAnimation(transition, forKey: nil)
		}

	
    func startNewRound() {
			
				round += 1
        targetValue = 1 + Int(arc4random_uniform(100)) // Generates a random number between 1 and 100. The 1 + part is required to have arc4random use up to and including 100.
        currentValue = 50
        slider.value = Float(currentValue) // UISlider only works with Floats, so this takes currentValue which is an Int and puts it back to a Float.
		}
	
		func startNewGame() {
		
				score = 0
				round = 0
				startNewRound()
	}
	
		func updateLabels() {
		
		/*
		The targetLabel outlet references a UILabel object. The UILabel object has a text property, which is a string object. You can only put string values into text but the above line tries to put targetValue into it, which is an Int. 
		That won’t fly because an Int and a string are two very different kinds of things. So you have to convert the Int into a string, and that is what String(targetValue) does. It’s similar to what you’ve seen before with Float(...) and Int(...).
		You could also do targetLabel.text = "\(targetValue)" The choice is purely preference. 
		*/
		
			targetLabel.text = String(targetValue)
			//targetLabel.text = "\(targetValue)" // You could also do it this way.
			scoreLabel.text = String(score)  // Have to convert the var score which is an Int into a String and then give that string to the label's text property.
			roundLabel.text = String(round)
		
		
	}
	
	


}

