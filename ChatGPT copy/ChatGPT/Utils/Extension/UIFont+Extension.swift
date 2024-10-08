//
//  UIFont+Extension.swift
//  ChatGPT
//
//  Created by Nathalia Neves on 08/10/24.
//

import Foundation
import UIKit

extension UIFont {
    static func helveticaNeueMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
