//
//  BeachGalleryModel.swift
//  HeyBeach
//

import UIKit

enum BeachGalleryModel {
    
    enum Fetch {
        struct Request {
        }
        
        struct Response {
            let beachList: [Beach]
        }
        
        enum ViewModel {
            struct Success {
                let beachList: [Beach]
            }
            
            struct Failure {
            }
        }
    }
    
    struct Beach {
        var image: UIImage?
    }
}
