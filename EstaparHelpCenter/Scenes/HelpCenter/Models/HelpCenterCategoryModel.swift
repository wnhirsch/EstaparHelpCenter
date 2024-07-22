//
//  HelpCenterCategoryModel.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 19/07/24.
//

import Foundation

struct HelpCenterCategoryModel: Decodable {
    let id: String
    let title: String
    let type: ItemType
    let category: String?
    let header: HelpCenterHeaderModel
    let items: [Section]
    
    struct Section: Decodable {
        let id: String
        let title: String
        let type: ItemType
        var items: [Article]
        
        struct Article: Decodable {
            let id: String
            let title: String
            let type: ItemType
        }
    }
    
    enum ItemType: String, Decodable {
        case category, section, article
    }
}
