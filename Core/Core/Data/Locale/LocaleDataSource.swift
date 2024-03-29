//
//  LocaleDataSource.swift
//  The Games (iOS)
//
//  Created by iOS Dev on 11/19/21.
//

import Foundation
import RealmSwift
import Combine
import Common

public protocol LocaleDataSourceProtocol {
    func getFavoriteList() -> AnyPublisher<[FavoriteEntity], Error>
    func addFavorite(_ favorite: FavoriteEntity) -> AnyPublisher<Bool, Error>
    func deleteFavorite(_ favorite: FavoriteEntity) -> AnyPublisher<Bool, Error>
}

public final class LocaleDataSource: NSObject {
    public let realm2 = try? Realm()
    public let realm: Realm?
    
    public init(realm: Realm?) {
        self.realm = realm
    }
    
    public static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
        return LocaleDataSource(realm: realmDatabase)
    }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    public func getFavoriteList() -> AnyPublisher<[FavoriteEntity], Error> {
        return Future<[FavoriteEntity], Error> { completion in
            if let realm = self.realm2 {
                let favoriteList: Results<FavoriteEntity> = {
                    realm.objects(FavoriteEntity.self)
                        .sorted(byKeyPath: "timestamp", ascending: true)
                }()
                completion(.success(favoriteList.toArray(ofType: FavoriteEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    public func addFavorite(_ favorite: FavoriteEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(favorite, update: .all)
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    public func deleteFavorite(_ favorite: FavoriteEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.delete(realm.objects(FavoriteEntity.self).filter("gameID=%@", favorite.gameID))

                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
}

public extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
}
