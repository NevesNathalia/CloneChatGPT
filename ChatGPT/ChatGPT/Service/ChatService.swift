//
//  ChatService.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 10/9/24.
//

import UIKit

class ChatService {
    private let baseUrl = "https://api.openai.com"
    
    var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(APIKeys.authToken)",
                                               "Content-Type": "application/json"
        ]
        return URLSession(configuration: configuration)
    }
    
    func requestChat(_ text: String, completion: @escaping (Result<Response, Error>) -> Void) {
        let path = "/v1/chat/completions"
        let urlString = baseUrl + path
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            let httpBody = Request(
                model: "gpt-4o-mini",
                messages: [MessageElement(role: "user", content: text)],
                temperature: 0.7
            )
            request.httpBody = try JSONEncoder().encode(httpBody)
        } catch {
            completion(.failure(error))
            return
        }
        
        session.dataTask(with: request) { data, response, error in
            NetworkLogger.log(request: request, response: response as? HTTPURLResponse, data: data)
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data else { return }
            
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    func requestImage(_ prompt: String, completion: @escaping (Result<ImageResponse, Error>) -> Void) {
        let path = "/v1/images/generations"
        let urlString = baseUrl + path
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            let body = RequestImage(
                model: "dall-e-3",
                prompt: prompt,
                n: 1,
                size: "1024x1024"
            )
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            completion(.failure(error))
            return
        }
        
        session.dataTask(with: request) { data, response, error in
            NetworkLogger.log(request: request, response: response as? HTTPURLResponse, data: data)
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else { return }
            
            do {
                let response = try JSONDecoder().decode(ImageResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

