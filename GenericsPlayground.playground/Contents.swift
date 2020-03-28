import UIKit
import CoreData

protocol EntityProtocol { }
protocol RepositoryProtocol {
    associatedtype E: EntityProtocol
    func create() -> E
    // func update(item: E)
}

class CoreDataEntity: NSManagedObject, EntityProtocol { }
class CoreDataRepository<E: CoreDataEntity>: RepositoryProtocol {
    func create() -> E {
        fatalError()
    }
//    func update(item: E) {
//        fatalError()
//    }
}


class CustomDataEntity: NSManagedObject, EntityProtocol { }
class CustomDataRepository<E: CustomDataEntity>: RepositoryProtocol {
    func create() -> E {
        fatalError()
    }
//    func update(item: E) {
//        fatalError()
//    }
}

class AnyEntity: EntityProtocol { }
class AnyRepository<E: EntityProtocol>: RepositoryProtocol {
    
    private let _create: () -> E
    
    func create() -> E {
        _create()
    }
    
    init<T: RepositoryProtocol>(_ base: T) where T.E == E {
        _create = base.create
    }
    
}

// Service
class UserEntity: EntityProtocol { }
class UserService {
    // var repo: AnyRepository<UserEntity>! = CoreDataRepository<AnyEntity>()
    var repo: AnyRepository<UserEntity>! = AnyRepository(CoreDataRepository<UserEntity>) //CoreDataRepository<>
}
