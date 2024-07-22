//
//  HelpCenterService.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 18/07/24.
//

import Moya

class HelpCenterService {
    
    private let provider: MoyaProvider<Target> = APIProvider<Target>().build()

    enum Target {
        case getCategories
        case getCategory(id: String)
    }
}

// MARK: Service Definition
extension HelpCenterService.Target: APITarget {
    
    var path: String {
        switch self {
        case .getCategories:
            return "categories"
        case .getCategory(let id):
            return "categories/\(id)"
        }
    }

    var method: Method {
        switch self {
        case .getCategories, .getCategory:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getCategories, .getCategory:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
       return sessionHeader()
    }
}

// MARK: Service Providers
extension HelpCenterService {
    
    func getCategories(completion: @escaping Completion) {
        provider.request(.getCategories, completion: completion)
    }
    
    func getCategory(id: String, completion: @escaping Completion) {
        provider.request(.getCategory(id: id), completion: completion)
    }
}
