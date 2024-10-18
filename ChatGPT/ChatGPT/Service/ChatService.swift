//
//  ChatService.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 10/9/24.
//

import UIKit

class ChatService {
    
    private let service: Service
    
    init() {
        service = Service()
    }
    
    
    func sendOpenAIRequest(text: String, completion: @escaping (Result<String, OpenAIError>) -> Void) {
        service.resquetChat(text) { result in
            
            switch result {
            case .success(let result):
                completion(.success(result.choices.first?.message.content ?? ""))
            case .failure(let error):
                completion(.failure(.ApiError(error)))
                
            }
            
            
            //        token.sendCompletion(with: text, model: openAIModelType, maxTokens: 4000, completionHandler: { result in
            //            DispatchQueue.main.async {
            //                switch result {
            //                case .success(let model):
            //                    guard let text = model.choices?.first?.text else {
            //                        completion(.failure(.missingChoicesText))
            //                        return
            //                    }
            //                    completion(.success(text))
            //                case .failure(let error):
            //                    completion(.failure(.ApiError(error)))
            //                }
            //            }
            //        })
            
            
            
            
            
        }
        
        //    func sendMessage(text: String, completion: (Result<String, OpenAIError>) -> Void) {
        //        OpenAISwift(authToken: APIKeys.authToken).sendCompletion(with: text, model: .gpt3(.davinci), maxTokens: 4000) { result in
        //            switch result {
        //            case .success(let success):
        //                var message = success.choices?.first?.text ?? ""
        //                completion(.success(message))
        //            case .failure(let failure):
        //                completion(.failure(failure))
        //            }
        //        }
        //    }
    }
}
