//
//  NetworkLogger.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 10/14/24.
//

import Foundation

struct NetworkLogger {
    static func log(request: URLRequest?, response: HTTPURLResponse?, data: Data?, verbose: Bool = true) {
        print ("-------START OF REQUEST---------" )
        
        if let url = request?.url {
            print("Request URL: \(url.absoluteString)")
        }
        
        if let httpMethod = request?.httpMethod {
            print("HTTP Method: \(httpMethod)")
        }
        
        if verbose, let headers = request?.allHTTPHeaderFields {
            print("Headers: \(headers)")
        }
        
        if verbose, let body = request?.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            print("Body Request: \(bodyString)")
        }
        
        if let httpResponse = response {
            let statusCode = httpResponse.statusCode
            let statusIcon = (200...299).contains(statusCode) ? "✅" : "❌"
            print("Status Code: \(statusCode) \(statusIcon)")
        }
        
        if verbose, let headers = (response)?.allHeaderFields as? [String: Any] {
            print("Response Headers: ⬇️\(headers)")
        }
        
        if let data = data {
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print("Response Body: \n\(jsonString)")
                }
                
            } catch let serializationError {
                print("Failed to serialize JSON: \(serializationError.localizedDescription)")
            }
        }
        print("------------------END OF REQUEST------------------")
    }
}
