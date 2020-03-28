//
//  ViewController.swift
//  Protocols
//
//  Created by LAP12230 on 3/24/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.testPropertyWrapper()
    }
    
    
    func testPropertyWrapper() {
        
//        var p1 = People(number: 0)
//        
//        let thread1 = Thread {
//            for _ in 1...5 {
//                p1.number += 1
//            }
//            // debugPrint("done thread 1: \(p1.age)")
//        }
//        
//        let thread2 = Thread {
//            for _ in 1...5 {
//                p1.number -= 1
//            }
//            // debugPrint("done thread 2: \(p1.age)")
//        }
//        
//        thread1.start()
//        thread2.start()
//        
//        sleep(1)
//        debugPrint("done: \(p1.number)")
        
        let service = UserService()
        service.requestCreateUser()
        
    }

}

