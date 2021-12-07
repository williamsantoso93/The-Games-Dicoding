//
//  Injection.swift
//  The Games (iOS)
//
//  Created by iOS Dev on 11/18/21.
//

import Foundation
import RealmSwift
import Core
import Detail
import Favorite

public final class Injection: NSObject {
    let realm = try? Realm()
    
    public func provideRepository() -> GameRepositoryProtocol {
        let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return GameRepository.sharedInstance(locale, remote)
    }
    
    public func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    public func provideDetail(gamedID: Int) -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository)
    }

    public func provideFavorite() -> FavoriteUseCase {
        let repository = provideRepository()
        return FavoriteInteractor(repository: repository)
    }
}
