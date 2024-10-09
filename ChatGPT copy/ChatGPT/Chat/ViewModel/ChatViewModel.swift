//
//  ChatViewModel.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 10/8/24.
//

import UIKit

class ChatViewModel {
    
    private var messageList: [Message] = []
    
    public func addMessage(message: String, type: TypeMessage) {
        messageList.insert(Message(message: message.trimmingCharacters(in: .whitespacesAndNewlines), date: Date(), typeMessage: type), at: .zero)
    }
    
    public func loadCurrentMessages(indexPath: IndexPath) -> Message {
        messageList[indexPath.row]
    }
    
    public var numberOfRowsInSection: Int {
        messageList.count
    }
}
