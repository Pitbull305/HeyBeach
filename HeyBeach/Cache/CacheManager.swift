//
//  CacheManager.swift
//  HeyBeach
//

import UIKit

class CacheManager {
    
    // MARK: - Properties
    private static let beachImagesCache = NSCache<AnyObject, AnyObject>()
    
    // MARK: - Methods
    static func storeImageInBeachImagesCache(_ id: String, _ image: UIImage) {
        beachImagesCache.setObject(image, forKey: id as AnyObject)
    }
    
    static func getImageFromBeachImagesCache(_ id: String) -> UIImage? {
        return beachImagesCache.object(forKey: id as AnyObject) as? UIImage
    }
}
