import UIKit
import Foundation

@propertyWrapper struct Capitalized {
    
    var wrappedValue: String {
        didSet { wrappedValue = wrappedValue.uppercased() }
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.uppercased()
    }
}

struct User {
    @Capitalized var firstName: String
    @Capitalized var lastName: String
}

extension User: CustomStringConvertible {
    var description: String {
        return "User: \(firstName) - \(lastName)"
    }
}

var user = User(firstName: "aaa", lastName: "bbb")
user.firstName = "ccc"

