//
//  HomeViewModel.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 01/05/23.
//

import UIKit

class HomeViewModel {
    private var businessResult: [Business_] = []
    
    func searchBusiness(with term: String, completion: @escaping (Result<Void, Error>) -> Void) {
        APIService.shared.loadBusinessResult(with: term) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let businessResult):
                    self?.businessResult = businessResult
                    completion(.success(()))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    var numberOfBusiness: Int {
        return businessResult.count
    }
    
    func businessImageUrl(at index: Int) -> String {
        return businessResult[index].image_url
    }
    
    func businessName(at index: Int) -> String {
        return businessResult[index].name
    }
    
    func businessReviewCount(at index: Int) -> Int {
        return businessResult[index].review_count
    }
    
    func businessrating(at index: Int) -> Float {
        return businessResult[index].rating
    }
    
    func business(at index: Int) -> Business_ {
        return businessResult[index]
    }
    
}




