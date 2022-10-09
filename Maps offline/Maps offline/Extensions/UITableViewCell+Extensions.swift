//
//  UITableViewCell+Extensions.swift
//  Maps offline
//
//  Created by ДМИТРИЙ СВЕТЛИЧНЫЙ on 02.10.2022.
//

import UIKit

extension UITableViewCell {
    func addSubviews(views: [UITableViewCell]) {
        views.forEach { addSubview($0) }
    }
}
