//
//  Categories.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 02/05/23.
//

import Foundation

struct Category {
    var title: String
    var imageName: String
}

struct CategoriesList {
   static var categories: [Category] = [
    Category(title: "American", imageName: "American"),
    Category(title: "Bakeries", imageName: "Bakeries"),
    Category(title: "Burgers", imageName: "Burgers"),
    Category(title: "Cocktail-Bars", imageName: "Cocktail-Bars"),
    Category(title: "French", imageName: "French"),
    Category(title: "Italian", imageName: "Italian"),
    Category(title: "Ramen", imageName: "Ramen"),
    Category(title: "Sandwiches", imageName: "Sandwiches"),
    Category(title: "Seafood", imageName: "Seafood"),
    Category(title: "Soup", imageName: "Soup"),
    Category(title: "Sushi", imageName: "Sushi"),
    Category(title: "Steakhouse", imageName: "Steakhouse"),
    ]
}
