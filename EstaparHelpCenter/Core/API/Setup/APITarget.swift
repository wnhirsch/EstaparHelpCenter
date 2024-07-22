//
//  APITarget.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 18/07/24.
//

import Moya

protocol APITarget: TargetType {
    var endPoint: Endpoint { get }
    var defaultJSONEncoder: JSONEncoder { get }
}

extension APITarget {

    var baseURL: URL {
        return URL(string: "https://helpcenter.dev.homolog.me/v1/helpcenter/")!
    }

    var sampleData: Data {
        return Data()
    }

    var headers: [String: String]? {
        return nil
    }

    var endPoint: Endpoint {
        return Endpoint(
            url: "\(baseURL)\(path)",
            sampleResponseClosure: { .networkResponse(200, self.sampleData) },
            method: method,
            task: task,
            httpHeaderFields: headers
        )
    }

    var validationType: ValidationType {
        return .successCodes
    }

    var defaultJSONEncoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }

    func jsonEncoder(dateFormat: String) -> JSONEncoder {
        let encoder = defaultJSONEncoder

        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        encoder.dateEncodingStrategy = .formatted(formatter)

        return encoder
    }

    func sessionHeader() -> [String: String]? {
        return [:]
    }
}
