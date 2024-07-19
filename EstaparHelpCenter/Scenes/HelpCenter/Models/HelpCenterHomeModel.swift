//
//  HelpCenterHomeModel.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 18/07/24.
//

import Foundation

struct HelpCenterHomeModel: Decodable {
    let header: Header
    let items: [Category]
    
    struct Header: Decodable {
        let image: ImageSizes
        let line1: String
        let line2: String
        
        struct ImageSizes: Decodable {
            let size1: String
            let size2: String
            let size3: String
            
            private enum CodingKeys: String, CodingKey {
                case size1 = "@1x"
                case size2 = "@2x"
                case size3 = "@3x"
            }
        }
    }
    
    struct Category: Decodable {
        let id: String
        let title: String
        let category: String?
        let totalArticles: Int
    }
}
