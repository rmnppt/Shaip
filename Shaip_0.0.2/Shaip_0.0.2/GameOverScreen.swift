//
//  GameOverScreenViewController.swift
//  Shaip
//
//  Created by Roman on 05/02/2015.
//  Copyright (c) 2015 roman. All rights reserved.
//

import UIKit

class GameOverScreen: UIViewController {

    @IBOutlet weak var scoreMessage: UILabel!
    
    var finalScore: Int?
    var shapesFound: Array<String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let highScore = getHighScore()
        
        if finalScore > highScore {
            scoreMessage.text = "Congratulations you got the highest score so far.\nYou scored \(finalScore!) points."
        } else {
            scoreMessage.text = "You scored \(finalScore!) points.\nYour highest score is \(highScore!)"
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
