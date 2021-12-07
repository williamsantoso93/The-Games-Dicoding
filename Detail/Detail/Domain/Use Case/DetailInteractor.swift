//
//  DetailInteractor.swift
//  The Games (iOS)
//
//  Created by iOS Dev on 11/18/21.
//

import Foundation
import Combine
import Core

public protocol DetailUseCase {
    func getDetail(_ gameID: Int) -> AnyPublisher<DetailGame, Error>
    func getFavoriteList() -> AnyPublisher<[GameData], Error>
    func addFavorite(_ favorite: DetailGame) -> AnyPublisher<Bool, Error>
    func deleteFavorite(_ favorite: DetailGame) -> AnyPublisher<Bool, Error>
}

public class DetailInteractor: DetailUseCase {
    public let repository: GameRepositoryProtocol
    
    public required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    public func getFavoriteList() -> AnyPublisher<[GameData], Error> {
        return repository.getFavoriteList()
    }
    
    public func getDetail(_ gameID: Int) -> AnyPublisher<DetailGame, Error> {
        repository.getDetail(gameID)
    }
    
    public func addFavorite(_ favorite: DetailGame) -> AnyPublisher<Bool, Error> {
        repository.addFavorite(favorite)
    }
    
    public func deleteFavorite(_ favorite: DetailGame) -> AnyPublisher<Bool, Error> {
        repository.deleteFavorite(favorite)
    }
}
