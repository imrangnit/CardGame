//
//  CMNavigationViewController.swift
//  Colour Memory
//
//  Created by MOHD IMRAN on 26/02/17.
//  Copyright © 2017 MOHD IMRAN. All rights reserved.
//

import UIKit

class CMNavigationViewController: UINavigationController {

    override init(rootViewController: UIViewController) {
    
        super.init(rootViewController: rootViewController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

