//
//  UIButton+Extension.swift
//  ChatGPT
//
//  Created by Gabriel Mors  on 10/9/24.
//

import Foundation
import UIKit

extension UIButton {
    func touchAnimation() {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: 0.80, y: 0.80)
        }, completion: { finish in UIButton.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.transform = .identity
            })
        })
    }
}
