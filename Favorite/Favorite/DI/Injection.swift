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

final class Injection: NSObject {
    let realm = try? Realm()
    
    private func provideRepository() -> GameRepositoryProtocol {
        let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return GameRepository.sharedInstance(locale, remote)
    }
    
    func provideDetail(gamedID: Int) -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository)
    }
}
