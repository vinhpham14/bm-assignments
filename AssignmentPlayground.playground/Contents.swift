import UIKit
import Foundation

// Thread safe variable
@propertyWrapper
class ThreadSafe<T> {
    
    private let lock: NSLock = NSLock()
    private var _value: T
    
    var wrappedValue: T {
        get {
            debugPrint(lock)
            lock.lock()
            defer { lock.unlock(); debugPrint("unlock"); debugPrint(lock) }
            
            return _value
        }
        
        set {
            debugPrint(lock)
            lock.lock()
            defer { lock.unlock(); debugPrint("unlock"); debugPrint(lock) }
            
            _value = newValue
        }
    }
    
    init(wrappedValue value: T) {
        _value = value
    }
    
}

class People: CustomStringConvertible {
    
    @ThreadSafe<Int> var age: Int
    
    var description: String {
        return "age: \(age)"
    }
    
    init(age: Int) {
        self.age = age
    }
}

var p1 = People(age: 0)

var thread1 = Thread {
    for _ in 1...5 {
        p1.age = p1.age + 1
    }
}

var thread2 = Thread {
    for _ in 1...5 {
        p1.age = p1.age + 1
    }
}

debugPrint("=====")

thread1.start()
thread2.start()

sleep(2)
p1.age

debugPrint("=====")
