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

// ====
//
//@propertyWrapper struct UserDefaultsBacked<Value> {
//    let key: String
//    let defaultValue: Value
//    var storage: UserDefaults = .standard
//
//    var wrappedValue: Value {
//        get {
//            let value = storage.value(forKey: key) as? Value
//            return value ?? defaultValue
//        }
//        set {
//            storage.setValue(newValue, forKey: key)
//        }
//    }
//}
//
//extension UserDefaultsBacked where Value: ExpressibleByNilLiteral {
//    init(key: String, storage: UserDefaults = .standard) {
//        self.init(key: key, defaultValue: nil, storage: storage)
//    }
//}
//
//struct SettingsViewModel {
//    @UserDefaultsBacked(key: "mark-as-read", defaultValue: true)
//    var autoMarkMessagesAsRead: Bool
//
//    @UserDefaultsBacked(key: "search-page-size", defaultValue: 20)
//    var numberOfSearchResultsPerPage: Int
//
//    @UserDefaultsBacked(key: "signature")
//    var messageSignature: String?
//}
