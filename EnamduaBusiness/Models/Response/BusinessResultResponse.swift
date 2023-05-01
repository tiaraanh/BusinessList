//
//  BusinessResultResponse.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 01/05/23.
//

import Foundation

struct BusinessResultResponse: Decodable {
    let business: [BusinessResult]
    
    enum CodingKeys: String, CodingKey {
        case business
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        business = try container.decodeIfPresent([BusinessResult].self, forKey: .business) ?? []
    }
}
