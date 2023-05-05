//
//  Business.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 02/05/23.
//

import Foundation

struct BusinessResponse: Decodable {
    let businesses: [Business]
}

struct Business: Decodable {
    var id: String
    var alias: String
    var name: String
    var imageURL: String
    var isClosed: Bool
    var url: String
    var reviewCount: Int
    var categories: [Categories]
    var rating: Double
    var coordinates: Coordinates?
    var transactions: [String]
    var price: String?
    var location: Location?
    var phone: String
    var dispalyPhone: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case alias = "alias"
        case name = "name"
        case imageURL = "image_url"
        case isClosed = "is_closed"
        case url = "url"
        case reviewCount = "review_count"
        case categories = "categories"
        case rating = "rating"
        case coordinates = "coordinates"
        case transactions = "transactions"
        case price = "price"
        case location = "location"
        case phone = "phone"
        case dispalyPhone = "display_phone"
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        alias = try container.decodeIfPresent(String.self, forKey: .alias) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL) ?? ""
        isClosed = try container.decodeIfPresent(Bool.self, forKey: .isClosed) ?? false
        url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        reviewCount = try container.decodeIfPresent(Int.self, forKey: .reviewCount) ?? 0
        categories = try container.decodeIfPresent([Categories].self, forKey: .categories) ?? []
        rating = try container.decodeIfPresent(Double.self, forKey: .rating) ?? 0
        coordinates = try container.decodeIfPresent(Coordinates.self, forKey: .coordinates)
        transactions = try container.decodeIfPresent([String].self, forKey: .transactions) ?? []
        price = try container.decodeIfPresent(String.self, forKey: .price) ?? ""
        location = try container.decodeIfPresent(Location.self, forKey: .location)
        phone = try container.decodeIfPresent(String.self, forKey: .phone) ?? ""
        dispalyPhone = try container.decodeIfPresent(String.self, forKey: .dispalyPhone) ?? ""
    }
    
}

struct Categories: Decodable {
    var alias: String
    var title: String
    
}

struct Coordinates: Decodable {
    var latitude: Double
    var longitude: Double
}

struct Location: Decodable {
    var displayAddress: [String]
    
    enum CodingKeys: String, CodingKey {
        case displayAddress = "display_address"
    }
}
