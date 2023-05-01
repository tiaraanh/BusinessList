//
//  BusinessResult.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 01/05/23.
//

import Foundation

protocol Business_ {
    var id: String { get }
    var name: String { get }
    var image_url: String { get }
    var review_count: Int { get }
    var rating: Float { get }
}

struct BusinessResult: Decodable, Business_ {
    var id: String
    var name: String
    var image_url: String
    var review_count: Int
    var rating: Float
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image_url = "image_url"
        case review_count = "review_count"
        case rating
    
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        image_url = try container.decodeIfPresent(String.self, forKey: .image_url) ?? ""
        review_count = try container.decodeIfPresent(Int.self, forKey: .review_count) ?? 0
        rating = try container.decodeIfPresent(Float.self, forKey: .rating) ?? 0
    }
}
