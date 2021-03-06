//
//  BeachWorker.swift
//  HeyBeach
//

import UIKit

class BeachWorker {
    
    // MARK: - Properties
    private let endpoint = "http://techtest.lab1886.io:3000"
    
    // MARK: - Methods
    func fetchBeachList(page: Int, completionHandler: @escaping(_ rawBeachList: [RawBeach], _ success: Bool) -> Void) {
        let urlString = "\(endpoint)/beaches?page=\(page)"
        guard let url = URL(string: urlString) else {
            completionHandler([], false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.setValue("no-cache", forHTTPHeaderField: "Cache-Control")
        
        URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) in
            if error == nil, let data = data {
                do {
                    let decoder = JSONDecoder()
                    let rawBeachList = try decoder.decode([RawBeach].self, from: data)
                    completionHandler(rawBeachList, true)
                }
                catch {
                    completionHandler([], false)
                }
            }
            else {
                completionHandler([], false)
            }
        }).resume()
    }
    
    func fetchBeachImage(id: String, name: String, completionHandler: @escaping(_ image: UIImage?) -> Void) {
        let urlString = "\(endpoint)/images/\(name)"
        guard let url = URL(string: urlString) else {
            completionHandler(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = .reloadIgnoringLocalCacheData
        
        if let image = CacheManager.getImageFromBeachImagesCache(id) {
            completionHandler(image)
        }
        else {
            URLSession.shared.dataTask(with: request, completionHandler: {
                (data, response, error) in
                if error == nil, let data = data, let image = UIImage(data: data) {
                    CacheManager.storeImageInBeachImagesCache(id, image)
                    completionHandler(image)
                }
                else {
                    completionHandler(nil)
                }
            }).resume()
        }
    }
}
