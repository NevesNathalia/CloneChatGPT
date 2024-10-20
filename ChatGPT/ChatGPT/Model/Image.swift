//
//  Image.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 10/19/24.
//

import Foundation

// MARK: - ImageResponse
struct ImageResponse: Codable {
    let created: Int
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let url: String
}

// MARK: - RequestImage
struct RequestImage: Codable {
    let model, prompt: String
    let n: Int
    let size: String
}
