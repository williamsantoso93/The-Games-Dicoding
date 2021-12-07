//
//  GameModel.swift
//  The Games
//
//  Created by William Santoso on 14/08/21.
//

import Foundation

// MARK: - Result
public struct GameData: Codable {
    public init(gameID: Int, name: String, released: String? = nil, backgroundImage: String? = nil, rating: Double? = nil, ratingTop: Int? = nil, parentPlatforms: [Item]? = nil, genres: [Item]? = nil) {
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
    public var releasedDate: Date? {
        if let released = released {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.date(from: released)!
        }
        return nil
    }
    public var backgroundImage: String?
    public var rating: Double?
    public var ratingTop: Int?
    public var parentPlatforms: [Item]?
    public var genres: [Item]?
}

// MARK: - DetailGame
public struct DetailGame: Codable {
    public init(detailID: Int, name: String, released: String?, backgroundImage: String?, rating: Double?, ratingTop: Int?, parentPlatforms: [ParentPlatform]?, developers: [Item]?, genres: [Item]?, publishers: [Item]?, description: String) {
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
    public var releasedDate: Date? {
        if let released = released {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.date(from: released)!
        }
        return nil
    }
    public let backgroundImage: String?
    public let rating: Double?
    public let ratingTop: Int?
    public let parentPlatforms: [ParentPlatform]?
    public let developers: [Item]?
    public let genres: [Item]?
    public let publishers: [Item]?
    public let description: String
}

// MARK: - Item
public struct Item: Codable {
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

// MARK: - ParentPlatform
public struct ParentPlatform: Codable {
    public init(platform: Item) {
        self.platform = platform
    }
    
    public let platform: Item
}
