//
//  HelpCenterHeaderModel.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 19/07/24.
//

import Foundation

struct HelpCenterHeaderModel: Decodable {
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
