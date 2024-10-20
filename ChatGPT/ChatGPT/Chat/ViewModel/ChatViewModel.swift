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
    
    public func removeLastMessage() {
        messageList.removeAll { message in
            message.typeMessage == .placeholder
        }
    }
    
    public func addMessage(message: String, type: TypeMessage) {
        messageList.insert(Message(message: message.trimmingCharacters(in: .whitespacesAndNewlines), typeMessage: type), at: .zero)
    }
    
    public func loadCurrentMessage(indexPath: IndexPath) -> Message {
        messageList[indexPath.row]
    }
    
    public func fetchMessage(from userMessage: String) {
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
        
    public func fetchImage(with prompt: String) {
        addMessage(message: "Criando a imagem...", type: .placeholder)
        
        service.requestImage(prompt) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                removeLastMessage()
                if let imageURL = response.data.first?.url {
                    self.addMessage(message: imageURL, type: .chatGPT)
                    self.delegate?.success()
                }
                
            case .failure(let error):
                let errorMessage = error.localizedDescription
                self.addMessage(message: errorMessage, type: .chatGPT)
                self.delegate?.error(message: errorMessage)
            }
            
        }
    }
    
    public func heightForRow(indexPath: IndexPath) -> CGFloat {
        let message = loadCurrentMessage(indexPath: indexPath)
        
        if let _ = URL(string: message.message), message.message.lowercased().contains("http") {
            return 200
        } else {
            return heightForText(indexPath: indexPath)
        }
    }
    
    private func heightForText(indexPath: IndexPath) -> CGFloat {
        let message = loadCurrentMessage(indexPath: indexPath).message
        let font = UIFont.helveticaNeueMedium(size: 16)
        let estimetedHeight = message.heightWithConstrainedWidth(width: 220, font: font)
        return estimetedHeight + 65
    }
    
//    public func heightForImage(from url: URL, completion: @escaping (CGFloat) -> Void) {
//        let maxCellHeight: CGFloat = 250.0
//        let defaultHeight: CGFloat = 200.0
//
//        DispatchQueue.global(qos: .background).async {
//            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
//                let imageRatio = image.size.height / image.size.width
//                let adjustedHeight = 220 * imageRatio
//                
//                DispatchQueue.main.async {
//                    completion(min(adjustedHeight, maxCellHeight))
//                }
//            } else {
//                DispatchQueue.main.async {
//                    completion(defaultHeight)
//                }
//            }
//        }
//    }
}

