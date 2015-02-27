//
//  ViewController.swift
//  Shaip
//
//  Created by roman on 30/01/2015.
//  Copyright (c) 2015 roman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var shapeOneContainer: UIView!
        @IBOutlet weak var shapeOne: UIImageView!
    @IBOutlet weak var shapeTwoContainer: UIView!
        @IBOutlet weak var shapeTwo: UIImageView!
    @IBOutlet weak var shapeThreeContainer: UIView!
        @IBOutlet weak var shapeThree: UIImageView!
    
    @IBOutlet weak var lifeCounterBox: UIView!
        @IBOutlet weak var lifeCounter: UILabel!
    
    @IBOutlet weak var levelCounter: UILabel!
    @IBOutlet weak var pointsCounter: UILabel!
    @IBOutlet weak var labelContainer: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var levelUpWindow: UIView!
        @IBOutlet weak var levelUpMessage: UILabel!
        @IBOutlet weak var levelUpShapeContainer: UIImageView!
        @IBOutlet weak var levelUpShapeLabel: UILabel!
    
    var correctAnswer:Int = 0
    var points = 0
    var lives = 5
    
    var shapesFound: Array<String> = []
    
    var timerTime = 5
    var timer: NSTimer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        levelUpWindow.hidden = true
        
        levelCounter.text = "\(level)"
        
        timerTime = 10
        timerLabel.text = "\(timerTime)"
        if(timer != nil){timer!.invalidate()}
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
        
        shapeOneContainer.hidden = false
        shapeTwoContainer.hidden = false
        shapeThreeContainer.hidden = false
        
        pointsCounter.text = String(points)
        correctAnswer = randomIndex([1, 2, 3])
        var randomTriplet = threeRandomCombos()
        
        shapeOneContainer.addSubview(shapeOne)
        shapeTwoContainer.addSubview(shapeTwo)
        shapeThreeContainer.addSubview(shapeThree)

        let transitionOptions = UIViewAnimationOptions.TransitionFlipFromLeft

        UIView.transitionWithView(shapeOneContainer, duration: 0.5, options: transitionOptions, animations: {
            self.shapeOne.image = UIImage(named: randomTriplet.0)
            }, completion: { finished in})
        UIView.transitionWithView(shapeTwoContainer, duration: 0.75, options: transitionOptions, animations: {
            self.shapeTwo.image = UIImage(named: randomTriplet.1)
            }, completion: { finished in})
        UIView.transitionWithView(shapeThreeContainer, duration: 1.0, options: transitionOptions, animations: {
            self.shapeThree.image = UIImage(named: randomTriplet.2)
            }, completion: { finished in})
        
        var tripletArray = [randomTriplet.0, randomTriplet.1, randomTriplet.2]
        var correctOne = tripletArray[correctAnswer]
        
        var colorWord = correctOne.componentsSeparatedByString("_")[0]
        var shapeWord = correctOne.componentsSeparatedByString("_")[1]
        
        labelContainer.text = "\(colorWord) \(shapeWord)"
        labelContainer.textColor = colors.colorsDictionary[correctOne.componentsSeparatedByString("_")[0]]
    }
    
    func updateTimer() {
        timerLabel.text = "\(--timerTime)"
        if timerTime == 0 {
            gameover()
        }
    }
    
    
    func levelUp() {
        if(timer != nil){timer!.invalidate()}
        level++
        var randomShapeIndex = randomIndex(levelUpShapes)
        var addedShape = levelUpShapes[randomShapeIndex]
        starterShapes.append(addedShape)
        shapesFound.append(addedShape)
        levelUpShapes.removeAtIndex(randomShapeIndex)
        allCombos = AllCombinations().allCombinations
        
        levelUpWindow.hidden = false
        levelUpMessage.text = "Well done, you have reached level \(level) and found a new shape"
        levelUpShapeContainer.image = UIImage(named: "\(randomColorString())_\(addedShape)")
        levelUpShapeLabel.text = addedShape
    }
    
    
    @IBAction func levelUpOkButtonPressed(sender: AnyObject) {
        levelUpWindow.hidden = true
        viewDidLoad()
    }
    
    func lifelost() {
        let transitionOptions = UIViewAnimationOptions.TransitionCurlUp
        UIView.transitionWithView(lifeCounterBox, duration: 0.5, options: transitionOptions, animations: {
            self.lifeCounter.text = String(--self.lives)
            if(self.lives <= 0) {
                self.gameover()
            }
            }, completion: { finished in})
    }


    // can i condense the three buttons into 1 by using sender information?
    @IBAction func shapeOnePressed(sender: AnyObject) {
        if correctAnswer == 0 {
            points = points + 1 * level
            if points == 10 || points == 20 || points == 40 || points == 100 || points == 150 || points == 200 {
                levelUp()
            } else {
                viewDidLoad()
            }
        } else {
            lifelost()
            shapeOneContainer.hidden = true
        }
    }
    
    @IBAction func shapeTwoPressed(sender: AnyObject) {
        if correctAnswer == 1 {
            points = points + 1 * level
            if points == 10 || points == 20 || points == 40 || points == 100 || points == 150 || points == 200 {
                levelUp()
            } else {viewDidLoad()}
        } else {
            lifelost()
            shapeTwoContainer.hidden = true
        }
    }
    
    @IBAction func shapeThreePressed(sender: AnyObject) {
        if correctAnswer == 2 {
            points = points + 1 * level
            if points == 10 || points == 20 || points == 40 || points == 100 || points == 150 || points == 200 {
                levelUp()
            } else {viewDidLoad()}
        } else {
            lifelost()
            shapeThreeContainer.hidden = true
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gameOver" {
            let gameOverScreen = segue.destinationViewController as GameOverScreen
            gameOverScreen.finalScore = points
            gameOverScreen.shapesFound = shapesFound
        }
    }
    
    
    func gameover() {
        self.performSegueWithIdentifier("gameOver", sender: self)
        if points > getHighScore() {
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setInteger(points, forKey: "highscore")
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

