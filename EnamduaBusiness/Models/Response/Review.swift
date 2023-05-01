//
//  ReviewResponse.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 01/05/23.
//

import Foundation

struct Review: Decodable {
    let id: String
    let text: String
    let rating: Int
    let user: [User]

    enum CodingKeys: String, CodingKey {
        case id
        case text
        case rating
        case user
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        text = try container.decodeIfPresent(String.self, forKey: .text) ?? ""
        rating = try container.decodeIfPresent(Int.self, forKey: .rating) ?? 0
        user = try container.decodeIfPresent([User].self, forKey: .user) ?? []
    }
}

