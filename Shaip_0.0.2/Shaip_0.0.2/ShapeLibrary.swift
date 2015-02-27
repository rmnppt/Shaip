//
//  ShapeLibrary.swift
//  Shaip
//
//  Created by roman on 30/01/2015.
//  Copyright (c) 2015 roman. All rights reserved.
//

import Foundation

var starterShapes = ["square", "circle", "triangle", "star"]
var levelUpShapes = ["pentagon", "ellipse", "hexagon", "kite", "rhombus", "trapezoid"]

var shapeColors = ["blue", "green", "red", "yellow", "pink"]

struct AllCombinations {
    
    var shapesArray  = starterShapes
    var colorsArray = shapeColors
    
    var allCombinations: Array<String>
    
    init (){
        allCombinations = []
        for colors in colorsArray {
            for shapes in shapesArray {
                var textToAppend = String("\(colors)_\(shapes)")
                allCombinations.append(textToAppend)
            }
        }
    }
}

var allCombos = AllCombinations().allCombinations



func randomIndex(inputArray: AnyObject) -> Int {
    var indexCount = inputArray.count
    var unsignedCount = UInt32(indexCount)
    var unsignedRandomNumber = arc4random_uniform(unsignedCount)
    var randomNumber = Int(unsignedRandomNumber)
    return randomNumber
}

func threeRandomCombos() -> (String, String, String) { // without replacement
    
    var combosToSample: Array<Int> = []
    combosToSample += 0..<allCombos.count

    var randomComboIndexOne = randomIndex(combosToSample)
    var randomComboIntOne = combosToSample[randomComboIndexOne]
    var randomComboOne = allCombos[randomComboIndexOne]
    combosToSample.removeAtIndex(randomComboIndexOne)

    var randomComboIndexTwo = randomIndex(combosToSample)
    var randomComboIntTwo = combosToSample[randomComboIndexTwo]
    var randomComboTwo = allCombos[randomComboIntTwo]
    combosToSample.removeAtIndex(randomComboIndexTwo)

    var randomComboIndexThree = randomIndex(combosToSample)
    var randomComboIntThree = combosToSample[randomComboIndexThree]
    var randomComboThree = allCombos[randomComboIntThree]
    
    return (randomComboOne, randomComboTwo, randomComboThree)

}

func randomColorString() -> String {
    return shapeColors[randomIndex(shapeColors)]
}

var level = 1

