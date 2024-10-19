//
//  ChatViewModel.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 10/8/24.
//

import UIKit

protocol ChatViewModelProtocol: AnyObject {
    func success()
    func error(message: String)
}

class ChatViewModel {
    
    private weak var delegate: ChatViewModelProtocol?
    private var messageList: [Message] = []
    private var service: ChatService = ChatService()
    
    public func setDelegate(_ delegate: ChatViewModelProtocol) {
        self.delegate = delegate
    }
    
    public var numberOfRowsInSection: Int {
        messageList.count
    }
    
    public func addMessage(message: String, type: TypeMessage) {
        messageList.insert(Message(message: message.trimmingCharacters(in: .whitespacesAndNewlines), typeMessage: type), at: .zero)
    }
    
    public func loadCurrentMessages(indexPath: IndexPath) -> Message {
        messageList[indexPath.row]
    }
    
    public func featchMessage(from userMessage: String) {
        service.requestChat(userMessage) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                let chatMessage = response.choices.first?.message.content ?? ""
                self.addMessage(message: chatMessage, type: .chatGPT)
                self.delegate?.success()
            case .failure(let error):
                let errorMessage = error.localizedDescription
                print(errorMessage)
                self.addMessage(message: errorMessage, type: .chatGPT)
                self.delegate?.error(message: errorMessage)
            }
        }
    }
        
    public func heightForRow(indexPath: IndexPath) -> CGFloat {
        let message = loadCurrentMessages(indexPath: indexPath).message
        let font = UIFont.helveticaNeueMedium(size: 16)
        let estimetedHeight = message.heightWithConstrainedWidth(width: 220, font: font)
        return estimetedHeight + 65
    }
    
}

