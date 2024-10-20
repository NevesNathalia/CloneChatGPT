//
//  Message.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 09/05/24.
//

import Foundation

enum TypeMessage {
    case user
    case chatGPT
    case placeholder
}

struct Message {
    var message: String
    var typeMessage: TypeMessage
}

// MARK: - Response
struct Response: Codable {
    let id, object: String
    let model: String
    let choices: [Choice]
}

// MARK: - Choice
struct Choice: Codable {
    let message: MessageElement
}

struct Request: Encodable {
    let model: String
    let messages: [MessageElement]
    let temperature: Double
}

struct MessageElement: Codable {
    let role, content: String
}
