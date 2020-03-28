//
//  DBProtocol.swift
//  Protocols
//
//  Created by LAP12230 on 3/26/20.
//  Copyright © 2020 LAP12230. All rights reserved.
//

import Foundation

protocol Entity {
    init()
}

protocol Repository {
    typealias E = Entity
    func write()
}

class CoreDataRepository<E: Entity>: Repository {
    func write() {
        print("CoreDataRepository")
    }
}
class CustomRepository<E: Entity>: Repository {
    func write() {
        print("CustomRepository")
    }
}

protocol UserEntity: Entity {
    var userName: String? { get }
}

protocol UserRepositoryProtocol {
    func createUser() -> UserEntity
}

protocol UserRepository: UserRepositoryProtocol {
    associatedtype E: UserEntity
    associatedtype R: Repository
    var repository: R { get }
}

extension UserRepository {
    func createUser() -> UserEntity {
        let e = E()
        print(String(describing: self.self))
        repository.write()
        print(String(describing: e.self))
        return e
    }
}


///====
class UserCoreDataEntity: NSObject, UserEntity {
    var userName: String?
    var fuck: String?
    required override init() {
        super.init()
    }
}
class UserCoreDataRepository: UserRepository {
    typealias E = UserCoreDataEntity
    typealias R = CoreDataRepository<UserCoreDataEntity>
    
    var repository: CoreDataRepository<UserCoreDataEntity> = CoreDataRepository()
    
}
///====


///====
class UserCustomEntity: UserEntity {
    var userName: String?
    required init() {
        
    }
}
class UserCustomRepository: UserRepository {
    typealias E = UserCustomEntity
    typealias R = CustomRepository<UserCustomEntity>
    var repository: CustomRepository<UserCustomEntity> = CustomRepository()
}
///====


class UserService {
    var repository: UserRepositoryProtocol = UserCoreDataRepository()
    func requestCreateUser() -> UserEntity? {
        return repository.createUser()
    }
}
