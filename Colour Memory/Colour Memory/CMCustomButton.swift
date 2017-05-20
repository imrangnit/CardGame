//
//  CMCustomButton.swift
//  Colour Memory
//
//  Created by MOHD IMRAN on 22/02/17.
//  Copyright © 2017 MOHD IMRAN. All rights reserved.
//

import UIKit

class CMCustomButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.backgroundColor = UIColor.darkGray
        
    }
    
}
