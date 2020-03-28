//
//  CustomLock.swift
//  Protocols
//
//  Created by LAP12230 on 3/26/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

import Foundation

class CustomLock: NSLocking {
    
    private var _lock: Any?

    @available (iOS 10.0, *)
    private var unfairLock: os_unfair_lock {
        get {
            if let lock = _lock as? os_unfair_lock {
                return lock
            }

            _lock = os_unfair_lock()
            return _lock as! os_unfair_lock
        }
        set {
            _lock = newValue
        }
    }

    private var spinLock: OSSpinLock {
        get {
            if let lock = _lock as? OSSpinLock {
                return lock
            }

            _lock = OS_SPINLOCK_INIT
            return _lock as! OSSpinLock
        }
        set {
            _lock = newValue
        }
    }
    
    // MARK: - NSLocking Protocols
    
    func lock() {
        if #available(iOS 10.0, *) {
            os_unfair_lock_lock(&unfairLock)
        } else {
            OSSpinLockLock(&spinLock)
        }
    }
    
    func unlock() {
        if #available(iOS 10.0, *) {
            os_unfair_lock_unlock(&unfairLock)
        } else {
            OSSpinLockUnlock(&spinLock)
        }
    }
    
}
