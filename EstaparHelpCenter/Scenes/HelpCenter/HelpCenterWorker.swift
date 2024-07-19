//
//  HelpCenterWorker.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 18/07/24.
//

import Foundation

class HelpCenterWorker {
    
    private let service: HelpCenterService
    
    init(service: HelpCenterService = .init()) {
        self.service = service
    }
    
    func getCategories(
        success: ((HelpCenterHomeModel) -> Void)? = nil,
        failure: (() -> Void)? = nil
    ) {
        service.getCategories { result in
            switch result {
            case let .success(response):
                do {
                    let model = try response.mapObject(HelpCenterHomeModel.self)
                    success?(model)
                } catch let error {
                    print(error)
                    failure?()
                }
            case let .failure(error):
                print(error)
                failure?()
            }
        }
    }
    
    func getCategory(
        id: String,
        success: ((HelpCenterCategoryModel) -> Void)? = nil,
        failure: (() -> Void)? = nil
    ) {
        service.getCategory(id: id) { result in
            switch result {
            case let .success(response):
                do {
                    let model = try response.mapObject(HelpCenterCategoryModel.self)
                    success?(model)
                } catch let error {
                    print(error)
                    failure?()
                }
            case let .failure(error):
                print(error)
                failure?()
            }
        }
    }
}
