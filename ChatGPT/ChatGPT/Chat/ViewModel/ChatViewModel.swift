//
//  ChatViewModel.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 10/8/24.
//

import UIKit

protocol ChatViewModelProtocol {
    func success()
    func error(message: String)
}

class ChatViewModel {
    
    private var delegate: ChatViewModelProtocol?
    private var messageList: [Message] = []
    private var service: ChatService = ChatService()
    
    public func delegate(delegate: ChatViewModelProtocol) {
        self.delegate = delegate
    }
    
    public func addMessage(message: String, type: TypeMessage) {
        messageList.insert(Message(message: message.trimmingCharacters(in: .whitespacesAndNewlines), typeMessage: type), at: .zero)
    }
    
    public func loadCurrentMessages(indexPath: IndexPath) -> Message {
        messageList[indexPath.row]
    }
    
    public var numberOfRowsInSection: Int {
        messageList.count
    }
    
//    public func fecthMessages(message: String) {
//        addMessage(message: message, type: .user)
//        service.sendOpenAIRequest(text: message, completion: { result in
//            switch result {
//            case .success(let success):
//                self.addMessage(message: success, type: .user)
//            case .failure(let failure):
//               self.addMessage(message: failure.localizedDescription, type: .chatGPT)
//            }
//        })
//    }
    
    public func featchMessage(message: String) {
        service.sendOpenAIRequest(text: message) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                print(success)
                self.addMessage(message: success, type: .chatGPT)
                self.delegate?.success()
            case .failure(let failure):
                print(failure.localizedDescription)
                self.addMessage(message: failure.localizedDescription, type: .chatGPT)
                self.delegate?.error(message: failure.localizedDescription)
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

