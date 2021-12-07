//
//  GameRepository.swift
//  The Games (iOS)
//
//  Created by iOS Dev on 11/18/21.
//

import Foundation
import Combine

public protocol GameRepositoryProtocol {
    func getListGames(nextPage: String?, searchText: String) -> AnyPublisher<GamesListResponse, Error>
    func getFavoriteList() -> AnyPublisher<[GameData], Error>
    func getDetail(_ gameID: Int) -> AnyPublisher<DetailGame, Error>
    func addFavorite(_ favorite: DetailGame) -> AnyPublisher<Bool, Error>
    func deleteFavorite(_ favorite: DetailGame) -> AnyPublisher<Bool, Error>
}

public class GameRepository {
    public typealias GameInstance = (LocaleDataSource, RemoteDataSource) -> GameRepository
    
    public let remote: RemoteDataSource
    public let locale: LocaleDataSource
    
    public init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }
    
    public static let sharedInstance: GameInstance = { localeRepo, remoteRepo in
        return GameRepository(locale: localeRepo, remote: remoteRepo)
    }
}

extension GameRepository: GameRepositoryProtocol {
    public func getListGames(nextPage: String? = nil, searchText: String) -> AnyPublisher<GamesListResponse, Error> {
        remote.getListGames(nextPage: nextPage, searchText: searchText)
            .eraseToAnyPublisher()
    }
    
    public func getDetail(_ gameID: Int) -> AnyPublisher<DetailGame, Error> {
        remote.getDetail(gameID)
            .map { GameMapper.mapDetailGameResponsesToDetailGame(input: $0)}
            .eraseToAnyPublisher()
    }
    
    public func getFavoriteList() -> AnyPublisher<[GameData], Error> {
        self.locale.getFavoriteList()
            .map { GameMapper.mapFavoriteListEntitiesToGameData(input: $0) }
            .eraseToAnyPublisher()
    }
    
    public func addFavorite(_ favorite: DetailGame) -> AnyPublisher<Bool, Error> {
        let favoriteEntity = GameMapper.mapDetailGameToFavoriteListEntities(input: favorite)
        return self.locale.addFavorite(favoriteEntity)
            .eraseToAnyPublisher()
    }
    
    public func deleteFavorite(_ favorite: DetailGame) -> AnyPublisher<Bool, Error> {
        let favoriteEntity = GameMapper.mapDetailGameToFavoriteListEntities(input: favorite)
        return self.locale.deleteFavorite(favoriteEntity)
            .eraseToAnyPublisher()
    }
}
