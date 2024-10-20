//
//  ImageTableViewCell.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 10/19/24.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: ImageTableViewCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addElement()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var messageImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private func addElement() {
        addSubview(messageImageView)
    }
    
    public func setupCell(with url: URL) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
                   guard let data = data, error == nil else {
                       print("Erro ao carregar imagem: \(error?.localizedDescription ?? "Unknown error")")
                       return
                   }
                   DispatchQueue.main.async {
                       self.messageImageView.image = UIImage(data: data)
                   }
               }.resume()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            
            messageImageView.topAnchor.constraint(equalTo: topAnchor),
            messageImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            messageImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
        ])
    }
}
