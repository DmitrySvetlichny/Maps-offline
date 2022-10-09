//
//  UIImageView+Extension.swift
//  Maps offline
//
//  Created by ДМИТРИЙ СВЕТЛИЧНЫЙ on 08.10.2022.
//

import Foundation
import UIKit

extension UIImageView {
    func withColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
