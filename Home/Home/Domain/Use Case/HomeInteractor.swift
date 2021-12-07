//
//  HomeInteractor.swift
//  The Games (iOS)
//
//  Created by iOS Dev on 11/18/21.
//

import Foundation
import Combine
import Core

public protocol HomeUseCase {
    func getListGames(nextPage: String?, searchText: String) -> AnyPublisher<GamesListResponse, Error>
}

public class HomeInteractor: HomeUseCase {
    public let repository: GameRepositoryProtocol
    
    public required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }
    
    public func getListGames(nextPage: String?, searchText: String) -> AnyPublisher<GamesListResponse, Error> {
        return repository.getListGames(nextPage: nextPage, searchText: searchText)
    }
}
