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
        let image: UIImage?
    }
}
