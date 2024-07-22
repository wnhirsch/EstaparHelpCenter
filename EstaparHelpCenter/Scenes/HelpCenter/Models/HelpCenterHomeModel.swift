//
//  HelpCenterHomeModel.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 18/07/24.
//

import Foundation

struct HelpCenterHomeModel: Decodable {
    let header: HelpCenterHeaderModel
    let items: [Category]
    
    struct Category: Decodable {
        let id: String
        let title: String
        let category: String?
        let totalArticles: Int
    }
}
