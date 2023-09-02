//
//  ChatGPTEndpoint.swift
//  MullingDomainGPT
//
//  Created by 송영모 on 2023/08/22.
//

import Foundation

import MullingShared

enum OPENAIEndpoint {
    case completion(request: ChatCompletionRequestDTO)
}

extension OPENAIEndpoint: Endpoint {
    var scheme: String {
        "https"
    }
    
    var host: String {
        "api.openai.com"
    }
    
    var path: String {
        switch self {
        case .completion:
            return "/v1/chat/completions"
        }
    }

    var method: RequestMethod {
        switch self {
        case .completion:
            return .post
        }
    }

    var header: [String: String]? {
        switch self {
        case .completion:
            return [
                "Authorization": "Bearer \(Environment.apiKey)",
                "Content-Type": "application/json"
            ]
        }
    }

    var body: [String: Any]? {
        switch self {
        case let .completion(request):
            return try? request.toDictionary()
        }
    }
}
