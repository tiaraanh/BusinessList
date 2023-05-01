//
//  Locations.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 30/04/23.
//

import Foundation

struct Locations: Decodable {
    let address1: String
    let address2: String
    let address3: String
    let city: String
    let zipCode: String
    let country: String
    let state: String
    let displayAddress: String

    enum CodingKeys: String, CodingKey {
        case address1
        case address2
        case address3
        case city
        case zipCode = "zip_code"
        case country, state
        case displayAddress = "display_address"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        address1 = try container.decode(String.self, forKey: .address1)
        address2 = try container.decode(String.self, forKey: .address2)
        address3 = try container.decode(String.self, forKey: .address3)
        city = try container.decode(String.self, forKey: .city)
        zipCode = try container.decode(String.self, forKey: .zipCode)
        country = try container.decode(String.self, forKey: .country)
        state = try container.decode(String.self, forKey: .state)
        displayAddress = try container.decode(String.self, forKey: .displayAddress)
    }
}
