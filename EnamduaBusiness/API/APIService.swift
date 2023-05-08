//
//  APIService.swift
//  EnamduaBusiness
//
//  Created by Tiara H on 28/04/23.
//

import Foundation

@available(iOS 16.0, *)
class APIService {
    static let shared = APIService()
    
    let baseURL = URL(string: "https://api.yelp.com/v3/")
    let apiKey = "JaTeKVxqBipTVkE2bkFvb-2FiM8lEyQr9rBLJw11zwAggv-6OT0EKdGo6E7d1tNF_T1Z4ZbchBYLe8tf-Glrd--BfVa3eWwtrdGrgV0SUK5gz1ddKgAS88j-sOFLZHYx"
    let endpointBusiness = "businesses"
    let endpointSearch = "search"
    let endpointReview = "id/reviews"
    
    func loadBusiness(searchTerm: String, completion: @escaping (Result<[Business], ErrorResponse>) -> Void ) {
        guard let url = baseURL else { return completion(.failure(.invalidURL)) }
        let urlBusinesses = url.appending(path: endpointBusiness)
        let urlAppend = urlBusinesses.appending(path: endpointSearch)
        
        print("Final URL: \(urlAppend)")
        
        var components = URLComponents(url: urlAppend, resolvingAgainstBaseURL: true)
        components?.queryItems = [
        URLQueryItem(name: "term", value: searchTerm),
        URLQueryItem(name: "location", value: "NYC"),
        URLQueryItem(name: "limit", value: "20")
        ]
        
        print("Components URL: \(String(describing: components?.url))")
        
        guard let componentsURL = components?.url else { return completion(.failure(.invalidURL)) }
        print("Built URL \(componentsURL)")
        
        var request =  URLRequest(url: componentsURL)
        request.httpMethod = "GET"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        print("Request: \(request)")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print("BUSINESS STATUS CODE: \(response.statusCode)")
                }
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
                do {
                    let apiData = try JSONDecoder().decode(BusinessResponse.self, from: data)
                    return completion(.success(apiData.businesses))
                } catch let error {
                    print(error.localizedDescription)
                    return completion(.failure(.unableToDecode))
                }
        }.resume()
    }
    
}




