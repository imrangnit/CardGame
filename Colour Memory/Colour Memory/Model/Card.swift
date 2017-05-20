//
//  Card.swift
//  Colour Memory
//
//  Created by MOHD IMRAN on 22/02/17.
//  Copyright © 2017 MOHD IMRAN. All rights reserved.
//

import UIKit

class Card: NSObject {

    var cardName:String! = ""
    var isCardFlipped:Bool! = false
    var index:Int! = 0
    var cardImageName:String! = ""
    var isCardMatchFailed:Bool = false
    
    convenience init(cardName:String,cardImageName:String,index:Int) {
        
        self.init()
        
        self.index = index
        self.cardName = cardName
        self.cardImageName = cardImageName
        
        
    }
}
