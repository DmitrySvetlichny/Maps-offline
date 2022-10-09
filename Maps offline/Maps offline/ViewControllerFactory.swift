//
//  ViewControllerFactory.swift
//  Maps offline
//
//  Created by ДМИТРИЙ СВЕТЛИЧНЫЙ on 30.09.2022.
//

import Foundation
import UIKit

class ViewControllerFactory {
    
    static func makeMainViewController() -> UIViewController {
        let viewModel = MainViewModel(deviceMemoryService: DeviceMemoryService(), networkservice: NetworkService())
        let mainViewController = MainViewController(viewModel: viewModel)
        return mainViewController
    }
    
    static func makeDetailedViewController(country: Country) -> UIViewController {
        let viewModel = DetailedViewModel(country: country, networkservice: NetworkService())
        let detailedViewController = DetailedViewController(viewModel: viewModel)
        return detailedViewController
    }
}
