//
//  Review.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 01/05/23.
//

import Foundation

struct ReviewResponse: Decodable {
    let review: [Review]
    
    enum CodingKeys: String, CodingKey {
        case review
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        review = try container.decodeIfPresent([Review].self, forKey: .review) ?? []
    }
}
