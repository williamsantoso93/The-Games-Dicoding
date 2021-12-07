//
//  GameResponse.swift
//  The Games (iOS)
//
//  Created by iOS Dev on 11/19/21.
//

import Foundation

// MARK: - ListGames
public struct GamesListResponse: Codable {
    public init(next: String?, previous: String?, results: [GameDataResponse]?) {
        self.next = next
        self.previous = previous
        self.results = results
    }
    
    public let next: String?
    public let previous: String?
    public let results: [GameDataResponse]?
    
    public enum CodingKeys: String, CodingKey {
        case next, previous, results
    }
}

// MARK: - Result
public struct GameDataResponse: Codable {
    public init(gameID: Int, name: String, released: String? = nil, backgroundImage: String? = nil, rating: Double? = nil, ratingTop: Int? = nil, parentPlatforms: [ItemResponse]? = nil, genres: [ItemResponse]? = nil) {
        self.gameID = gameID
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.ratingTop = ratingTop
        self.parentPlatforms = parentPlatforms
        self.genres = genres
    }
    
    public var gameID: Int
    public var name: String
    public var released: String?
    public var backgroundImage: String?
    public var rating: Double?
    public var ratingTop: Int?
    public var parentPlatforms: [ItemResponse]?
    public var genres: [ItemResponse]?
    
    public enum CodingKeys: String, CodingKey {
        case gameID = "id"
        case name, released
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case parentPlatforms = "parent_platforms"
        case genres
    }
}

// MARK: - Item
public struct ItemResponse: Codable {
    public init(itemID: Int?, name: String?) {
        self.itemID = itemID
        self.name = name
    }
    
    public let itemID: Int?
    public let name: String?
    
    public enum CodingKeys: String, CodingKey {
        case itemID = "id"
        case name
    }
}

// MARK: - DetailGame
public struct DetailGameResponse: Codable {
    public init(detailID: Int, name: String, released: String?, backgroundImage: String?, rating: Double?, ratingTop: Int?, parentPlatforms: [ParentPlatformResponse]?, developers: [ItemResponse]?, genres: [ItemResponse]?, publishers: [ItemResponse]?, description: String) {
        self.detailID = detailID
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.ratingTop = ratingTop
        self.parentPlatforms = parentPlatforms
        self.developers = developers
        self.genres = genres
        self.publishers = publishers
        self.description = description
    }
    
    public let detailID: Int
    public let name: String
    public let released: String?
    public let backgroundImage: String?
    public let rating: Double?
    public let ratingTop: Int?
    public let parentPlatforms: [ParentPlatformResponse]?
    public let developers: [ItemResponse]?
    public let genres: [ItemResponse]?
    public let publishers: [ItemResponse]?
    public let description: String
    
    public enum CodingKeys: String, CodingKey {
        case detailID = "id"
        case name
        case released
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case parentPlatforms = "parent_platforms"
        case developers
        case genres
        case publishers
        case description = "description_raw"
    }
}

// MARK: - ParentPlatform
public struct ParentPlatformResponse: Codable {
    public init(platform: ItemResponse) {
        self.platform = platform
    }
    
    public let platform: ItemResponse
}
