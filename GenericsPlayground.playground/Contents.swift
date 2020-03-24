import UIKit
import CoreData

/*

protocol EntityProtocol {
    associatedtype T
    init()
}

protocol DBService {
    associatedtype T
    func write<Entity: EntityProtocol>(item: Entity) where Entity.T == T
    func read<Entity: EntityProtocol>() -> Entity where Entity.T == T
}

final class CoreDataEntity: EntityProtocol {
    typealias T = NSManagedObject
    init() { }
}

final class CoreDataService: DBService {
    
    typealias T = NSManagedObject
    
    func read<Entity: EntityProtocol>() -> Entity where T == Entity.T {
        return Entity()
    }
    
    func write<Entity: EntityProtocol>(item: Entity) where T == Entity.T {
        // write
    }
    
}
*/

// =======

protocol EntityProtocol {
    
}

protocol DBService {
    associatedtype EntityType where EntityType == EntityProtocol
    func read() -> EntityType
    func write(item: EntityType)
}

class CoreDataEntity: EntityProtocol { }

class CoreDataService<T: EntityProtocol>: DBService {
    typealias EntityType = T
}

//class CoreDataService: DBService {
//    typealias EntityType = CoreDataEntity
//
//    func write(item: EntityType) {
//
//    }
//
//    func read() -> EntityType {
//        return EntityType()
//    }
//}


