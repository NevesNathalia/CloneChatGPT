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
}

struct Message {
    var message: String
    var date: Date
    var typeMessage: TypeMessage
}
