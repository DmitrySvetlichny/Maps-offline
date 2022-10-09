//
//  DetailedViewModel.swift
//  Maps offline
//
//  Created by ДМИТРИЙ СВЕТЛИЧНЫЙ on 01.10.2022.
//

import Foundation

class DetailedViewModel {
    
    private let networkService: NetworkService
    var country: Country
    var title: String {
        country.name.capitalized
    }
    
    var progressCallBack: ((Double, IndexPath) -> Void)?
    var completion: ((IndexPath) -> Void)?
    var selectedCellIndex: IndexPath?
    
    init(country: Country, networkservice: NetworkService) {
        self.country = country
        self.networkService = networkservice
        self.networkService.progressCallBack = { progress in
            self.progressCallBack?(progress, (self.selectedCellIndex!))
        }
        
        self.networkService.completion = {
            guard let index = self.selectedCellIndex else { return }
            self.completion?(index)
            self.selectedCellIndex = nil
        }
    }
    
    func selectRegion(with index: IndexPath) {
        selectedCellIndex = index
        let selectRegion = country.regions[index.row]
        networkService.createURLForRegion(with: selectRegion, country: country)
    }
    
    func updateDownloadProgress(progress: Double) {
        guard let index = selectedCellIndex?.row else { return }
        country.regions[index].downloadProgress = Float(progress)
    }
    
    func updateStateForRegion(with index: IndexPath) {
        country.regions[index.row].isMapDownload = true
    }
}
