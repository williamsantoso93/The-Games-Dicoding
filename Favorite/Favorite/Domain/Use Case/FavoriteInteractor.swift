//
//  FavoriteInteractor.swift
//  The Games (iOS)
//
//  Created by iOS Dev on 11/19/21.
//

import Foundation
import Combine
import Core

public protocol FavoriteUseCase {
    func getListGames() -> AnyPublisher<[GameData], Error>
}

public class FavoriteInteractor: FavoriteUseCase {
    private let repository: GameRepositoryProtocol
    
    public required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    public func getListGames() -> AnyPublisher<[GameData], Error> {
        return repository.getFavoriteList()
    }
}
