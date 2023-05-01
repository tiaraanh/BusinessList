//
//  BusinessResponse.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 01/05/23.
//

import Foundation

struct BusinessResponse: Decodable {
    let businesses: [Business]
    
    enum CodingKeys: String, CodingKey {
        case businesses
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        businesses = try container.decodeIfPresent([Business].self, forKey: .businesses) ?? []
    }
}
