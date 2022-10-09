//
//  CountryData.swift
//  Maps offline
//
//  Created by ДМИТРИЙ СВЕТЛИЧНЫЙ on 02.10.2022.
//

import Foundation
import UIKit

struct Country {
    let name: String
    var regions: [Region]
    let flagImage: UIImage
    let downloadImage: UIImage
    let moreImage: UIImage
    var isMapDownload: Bool = false
    var downloadProgress: Float = 0
}

struct Region {
    let name: String
    let flagImage: UIImage
    let downloadImage: UIImage
    var isMapDownload: Bool = false
    var downloadProgress: Float = 0
}
