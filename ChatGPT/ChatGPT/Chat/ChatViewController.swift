//
//  ViewController.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 09/05/24.
//

import UIKit

enum sideOfButton {
    case left
    case right
}

class ChatViewController: UIViewController {
    
    var screen: ChatScreen?
    var viewModel: ChatViewModel = ChatViewModel()

    override func viewWillAppear(_ animated: Bool) {
        configBarButton()
    }
    
    override func loadView() {
        screen = ChatScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.configTableView(delegate: self, dataSource: self)
        screen?.delegate(delegate: self)
        configBackground()
    }
    
    private func configBarButton() {
        configButtons(image: UIImage(systemName: "mic") ?? UIImage(), side: .left, action: #selector (startMic))
        configButtons(image: UIImage(systemName: "photo") ?? UIImage(), side: .right, action: #selector (startImage))
        
    }
    
    private func configButtons(image: UIImage, side: sideOfButton, action: Selector) {
        let button = UIBarButtonItem(image: image, style: .done, target: self, action: action)
        button.tintColor = .white
        switch side {
        case .left:
            navigationItem.leftBarButtonItem = button
        case .right:
            navigationItem.rightBarButtonItem = button
        }
    }
    
    private func configBackground() {
        view.backgroundColor = .background
    }
    
//    private func addMessage(message: String, type: TypeMessage) {
//        messageList.insert(Message(message: message.trimmingCharacters(in: .whitespacesAndNewlines), date: Date(), typeMessage: type), at: .zero)
//        reloadData()
//    }
    
    private func reloadData() {
        screen?.tableView.reloadData()
    }
    
    @objc private func startMic() {
        print("Botao pra iniciar o mic")
    }
    
    @objc private func startImage() {
        print("Botao pra iniciar a imagem")
    }
    
//    private func loadCurrentMessage(indexPath: IndexPath) -> Message {
//        return viewModel.loadCurrentMessages(indexPath: indexPath)
//    }
    
    private func heightForRow(indexPath: IndexPath) -> CGFloat {
        let message = viewModel.loadCurrentMessages(indexPath: indexPath).message
        let font = UIFont.helveticaNeueMedium(size: 16)
        let estimetedHeight = message.heightWithConstrainedWidth(width: 220, font: font)
        return estimetedHeight + 65
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = viewModel.loadCurrentMessages(indexPath: indexPath)
        
        switch message.typeMessage {
            
        case .user:
            let cell = tableView.dequeueReusableCell(withIdentifier: OutgoingTextMessageTableViewCell.identifier, for: indexPath) as? OutgoingTextMessageTableViewCell
            cell?.setupCell(data: message)
            return cell ?? UITableViewCell()
            
        case .chatGPT:
            let cell = tableView.dequeueReusableCell(withIdentifier: IncomingTextMessageTableViewCell.identifier, for: indexPath) as? IncomingTextMessageTableViewCell
            cell?.setupCell(data: message)
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow(indexPath: indexPath)
    }
}

extension ChatViewController: ChatScreenProtocol {
    
    func didSendMessage(_ message: String) {
        viewModel.addMessage(message: message, type: .user)
        reloadData()
    }
}
