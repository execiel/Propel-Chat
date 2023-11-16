//
//  ApiUtil.swift
//  Propelchat
//
//  Created by Zeke on 2023-11-14.
//

import Foundation

class ApiUtil {
    private static let ApiAdress = "http://localhost:3000/api/"
    
    static func fetchData<T: Decodable>(with request: URLRequest, completion: @escaping (T?) -> Void) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(decodedData)
            } catch {
                print("Something went wrong with decoding the response: \(error)")
                completion(nil)
            }
        }.resume()
    }

    static func createHttpRequest(endpoint: String, httpMethod: String, data: Codable) -> URLRequest? {
        print(ApiAdress+endpoint)
        // Connect to url
        guard let url = URL(string: ApiAdress+endpoint) else {
            print("Invalid URL")
            return nil
        }
        
        // Create json data
        guard let jsonData = try? JSONEncoder().encode(data) else {
            print("Error encoding JSON data")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        return request
    }
}
