//
//  NEws.swift
//  iOS_basics
//
//  Created by Arnaud SCHEID on 09/12/2020.
//

import Foundation

// MARK: - News
struct News: Codable {
    let count: Int
    let next: String
    let previous: JSONNull?
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let kind: String
    let domain: String
    let source: Source
    let title: String
    let publishedAt: String
    let slug: String
    let currencies: [Curr]?
    let id: Int
    let url: String
    let createdAt: String
    let votes: Votes

    enum CodingKeys: String, CodingKey {
        case kind, domain, source, title
        case publishedAt = "published_at"
        case slug, currencies, id, url
        case createdAt = "created_at"
        case votes
    }
}

// MARK: - Currency
struct Curr: Codable {
    let code, title, slug: String
    let url: String
}

enum Kind: String, Codable {
    case news = "news"
}

// MARK: - Source
struct Source: Codable {
    let title: String
    let region: Region
    let domain: String
    let path: String?
}

enum Region: String, Codable {
    case en = "en"
}

// MARK: - Votes
struct Votes: Codable {
    let negative, positive, important, liked: Int
    let disliked, lol, toxic, saved: Int
    let comments: Int
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
