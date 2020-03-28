//
//  WrappedProperties.swift
//  Protocols
//
//  Created by LAP12230 on 3/24/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

import Foundation
import UIKit

@propertyWrapper class ThreadSafe<T> {
    
    private var _value: T
    private var lock: CustomLock! = CustomLock()
    
    var wrappedValue: T {
        get {
            self.lock.lock()
            defer { self.lock.unlock() }
            return _value
        }
        
        set {
            self.lock.lock()
            defer { self.lock.unlock() }
            _value = newValue
        }
    }
    
    init(wrappedValue: T) {
        self._value = wrappedValue
    }
}

struct People {
    @ThreadSafe var number: Int
}
