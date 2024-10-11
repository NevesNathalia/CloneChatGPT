//
//  ServiceManager.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 10/11/24.
//

import Foundation
import OpenAISwift

enum OpenAIError: Error {
    case missingChoicesText
    case ApiError(Error)
}

class ServiceManager {
    let openAIModelType: OpenAIModelType = .gpt3(.davinci)
    let token: OpenAISwift = OpenAISwift(authToken: APIKeys.authToken)
}
