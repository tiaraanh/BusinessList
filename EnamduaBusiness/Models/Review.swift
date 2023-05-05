//
//  Review.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 04/05/23.
//

import Foundation

struct ReviewResponse: Decodable {
    let reviews: [ReviewList]
}

struct ReviewList: Decodable {
    let id: String?
    let text: String?
    let rating: Int
    let user: User?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case text = "text"
        case rating = "rating"
        case user = "user"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.text = try container.decodeIfPresent(String.self, forKey: .text) ?? ""
        self.rating = try container.decodeIfPresent(Int.self, forKey: .rating) ?? 0
        self.user = try container.decodeIfPresent(User.self, forKey: .user)
    }
}

struct User: Decodable {
    let name: String?
}
