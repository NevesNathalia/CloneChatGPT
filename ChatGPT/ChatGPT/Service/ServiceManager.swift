//
//  ServiceManager.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 10/11/24.
//

import Foundation
//import OpenAISwift

enum OpenAIError: Error {
    case missingChoicesText
    case ApiError(Error)
}

//class ServiceManager {
//    let openAIModelType: OpenAIModelType = .gpt3(.davinci)
//    let token: OpenAISwift = OpenAISwift(authToken: APIKeys.authToken)
//}


class Service {
    let baseUrl = "https://api.openai.com"
    
    var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(APIKeys.authToken)", "Content-Type": "application/json"]
        
        let session = URLSession(configuration: configuration)
        return session
    }
    
    func resquetChat(_ text: String, completion: @escaping (Result<Response, Error>) -> Void) {
        let path = "/v1/chat/completions"
        let urlString = baseUrl + path
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let httpBody = Request(model: "gpt-4o-mini", messages: [MessageElement(role: "user", content: text)], temperature: 0.7)
        let data = try? JSONEncoder().encode(httpBody)
        request.httpBody = data
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let data else { return }
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
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
