//
//  ViewController.swift
//  PaddingLabel
//
//  Created by LAP12230 on 3/23/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var paddingLabel: PaddingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.paddingLabel.textInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 20)
    }

    @IBAction func sizeToFit(_ sender: Any) {
        self.paddingLabel.sizeToFit()
    }

}

