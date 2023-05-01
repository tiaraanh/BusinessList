//
//  APIService.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 28/04/23.
//

import Foundation

class APIService {
    static let shared: APIService = APIService()
    private init() { }
    
    private let baseUrl: String = "https://api.yelp.com/v3/businesses"
    private let apiKey = "BearerJaTeKVxqBipTVkE2bkFvb-2FiM8lEyQr9rBLJw11zwAggv-6OT0EKdGo6E7d1tNF_T1Z4ZbchBYLe8tf-Glrd--BfVa3eWwtrdGrgV0SUK5gz1ddKgAS88j-sOFLZHYx"
    
    
    func loadBusiness(completion: @escaping (Result<[BusinessResult], Error>) -> Void) {
        let urlString = "\(baseUrl)/search?location=NYC&sort_by=best_match&limit=20="
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(apiKey, forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "accept")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                do {
                    let business = try JSONDecoder().decode(BusinessResultResponse.self, from: data)
                    completion(.success(business.business))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    func loadBusinessResult(with term: String, completion: @escaping (Result<[BusinessResult], Error>) -> Void) {
        guard let term = term.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            else { return }
        
        let urlString = "\(baseUrl)/search?location=NYC&term=\(term)&sort_by=best_match&limit=20="
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(apiKey, forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "accept")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                do {
                    let businessResult = try JSONDecoder().decode(BusinessResultResponse.self, from: data)
                    completion(.success(businessResult.business))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    func loadBusinessDetail(with id: String, completion: @escaping (Result<Business, Error>) -> Void) {
        guard let id = id.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        else {return}
        
        let urlString = "\(baseUrl)/\(id)"
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(apiKey, forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "accept")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                do {
                    let businessDetail = try JSONDecoder().decode(Business.self, from: data)
                    completion(.success(businessDetail))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    func loadBusinessReview(with id: String, completion: @escaping (Result<[Review], Error>) -> Void) {
        guard let id = id.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        else {return}
        
        let urlString = "\(baseUrl)/\(id)/reviews?limit=20&sort_by=yelp=_sort"
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(apiKey, forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "accept")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                do {
                    let businessReviw = try JSONDecoder().decode(ReviewResponse.self, from: data)
                    completion(.success(businessReviw.review))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
}


