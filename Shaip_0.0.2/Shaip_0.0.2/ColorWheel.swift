//
//  ColorWheel.swift
//  FunFacts
//
//  Created by Roman on 27/01/2015.
//  Copyright (c) 2015 Roman. All rights reserved.
//

import Foundation
import UIKit

struct ColorWheel {
    let colorsDictionary = [
        "blue": UIColor(red: 0/255.0, green: 150/255.0, blue: 255/255.0, alpha: 1.0),
        "green": UIColor(red: 115/255.0, green: 250/255.0, blue: 121/255.0, alpha: 1.0),
        "red": UIColor(red: 255/255.0, green: 38/255.0, blue: 0/255.0, alpha: 1.0),
        "yellow": UIColor(red: 255/255.0, green: 252/255.0, blue: 121/255.0, alpha: 1.0),
        "pink": UIColor(red: 255/255.0, green: 131/255.0, blue: 255/255.0, alpha: 1.0)
    ]
    
    func randomColor() -> UIColor {
        var colors = Array(self.colorsDictionary.values)
        var unsignedColorCount = UInt32(colors.count)
        var unsignedRandomNumber = arc4random_uniform(unsignedColorCount)
        var randomNumber = Int(unsignedRandomNumber)
        return colors[randomNumber]
    }
}

let colors = ColorWheel()

