//
//  UserWorker.swift
//  HeyBeach
//

import Foundation

class UserWorker {
    
    // MARK: - Properties
    private let endpoint = "http://techtest.lab1886.io:3000"
    
    // MARK: - Methods
    func signUp(email: String, password: String, completionHandler: @escaping(_ token: String?) -> Void) {
        let urlString = "\(endpoint)/user/register"
        guard let url = URL(string: urlString) else {
            completionHandler(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.setValue("no-cache", forHTTPHeaderField: "Cache-Control")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let bodyParameters = "email=\(email)&password=\(password)"
        request.httpBody = bodyParameters.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) in
            if error == nil, let response = response as? HTTPURLResponse, let token = response.allHeaderFields["x-auth"] as? String {
                completionHandler(token)
            }
            else {
                completionHandler(nil)
            }
        }).resume()
    }
}
