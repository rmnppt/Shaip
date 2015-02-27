//
//  MainMenu.swift
//  Shaip
//
//  Created by Roman on 02/02/2015.
//  Copyright (c) 2015 roman. All rights reserved.
//

import UIKit
import Foundation


func getHighScore() -> Int? {
    let defaults = NSUserDefaults.standardUserDefaults()
    var highscore: AnyObject? = defaults.objectForKey("highscore")
    if highscore != nil {
        return Int(highscore! as NSNumber)
    } else {
        return nil
    }
}

class MainMenu: UIViewController {
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var shapeImageNames: Array<String> = []
    func populateShapeImages() {
        for i in 0..<starterShapes.count {
            var thisImageName = "\(randomColorString())_\(starterShapes[i])"
            shapeImageNames.append(thisImageName)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateShapeImages()
        
        let offset = 40
        func displayUnlockedImages() {
            for j in 0..<starterShapes.count {
                var unsignedOffset = (CGFloat(j)*40)+20
                var position = CGRectMake(unsignedOffset, 40, 40, 40)
                var imageView = UIImageView(frame: position)
                imageView.image = UIImage(named: shapeImageNames[j])
                self.view.addSubview(imageView)
            }
        }
        displayUnlockedImages()

        var hScore = getHighScore()
        if hScore != nil {
            highScoreLabel.text = "High Score: \(hScore!)"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}





