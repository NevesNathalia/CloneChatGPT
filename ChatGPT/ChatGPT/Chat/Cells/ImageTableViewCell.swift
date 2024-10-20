//
//  ImageTableViewCell.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 10/19/24.
//

import UIKit
import Kingfisher

class ImageTableViewCell: UITableViewCell {
    
    static let identifier: String = String(describing: ImageTableViewCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        transform = CGAffineTransform(scaleX: 1, y: -1)
        selectionStyle = .none
        backgroundColor = .background
        addElement()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var messageImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        //        image.layer.cornerRadius = 20
        return image
    }()
    
    private func addElement() {
        contentView.addSubview(messageImageView)
    }
    
    public func setupCell(with url: URL) {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo")?.withTintColor(.lightGray)
        image.bounds.size.width = 200
        image.bounds.size.height = 200
        
        messageImageView.kf.placeholder?.add(to: image)
        messageImageView.kf.setImage(with: url)
        
        
        //        DispatchQueue.global(qos: .background).async {
        //            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
        //                DispatchQueue.main.async {
        //                    self.messageImageView.image = image
        //                    self.messageImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo")?.withTintColor(.lightGray))
        //                    completion()
        //                }
        //            } else {
        //                DispatchQueue.main.async {
        //                    self.messageImageView.image = UIImage(systemName: "photo")?.withTintColor(.lightGray)
        //                    completion()
        //                }
        //            }
        //        }
        
        //        URLSession.shared.dataTask(with: url) { data, response, error in
        //                   guard let data = data, error == nil else {
        //                       print("Erro ao carregar imagem: \(error?.localizedDescription ?? "Unknown error")")
        //                       return
        //                   }
        //                   DispatchQueue.main.async {
        //                       self.messageImageView.image = UIImage(data: data)
        //                   }
        //               }.resume()
    }
    
    //    private func loadImage(from url: URL) {
    //        DispatchQueue.global().async {
    //            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
    //                DispatchQueue.main.async {
    //                    self.messageImageView.image = image
    //                }
    //            } else {
    //                self.messageImageView.image = UIImage(systemName: "photo")?.withTintColor(.lightGray)
    //                print("Erro ao carregar a image!!!!")
    //            }
    //        }
    //    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            messageImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            messageImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            messageImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 220),
            messageImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            messageImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
