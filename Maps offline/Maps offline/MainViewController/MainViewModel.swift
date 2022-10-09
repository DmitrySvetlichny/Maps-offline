//
//  MainViewModel.swift
//  Maps offline
//
//  Created by ДМИТРИЙ СВЕТЛИЧНЫЙ on 30.09.2022.
//

import Foundation
import SWXMLHash

class MainViewModel {
    
    var parceCountries = [Country]()
    var countries = [Country]()
    private let deviceMemoryService: DeviceMemoryService
    private let networkService: NetworkService
    var progressCallBack: ((Double, IndexPath) -> Void)?
    var completion: ((IndexPath) -> Void)?
    var selectedCellIndex: IndexPath?
    
    init(deviceMemoryService: DeviceMemoryService, networkservice: NetworkService) {
        self.deviceMemoryService = deviceMemoryService
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
    
    func getDeviceMemoryData() -> DeviceMemoryData {
        DeviceMemoryData(freeSpace: deviceMemoryService.freeDiskSpace, progresValue: Float(deviceMemoryService.progressValue))
    }
    
    func parseXml() {
        if let path = Bundle.main.url(forResource: "regions", withExtension: "xml") {
            guard let xmlData = try? Data(contentsOf: path, options: .mappedIfSafe) else { return }
            let xml = XMLHash.config { _ in }.parse(xmlData)
            _ = xml["regions_list"]["region"][0]["region"].all.map { element in
                let countryName = element[0].element?.attribute(by: "name")?.text ?? ""
                let hasMap = element[0].element?.attribute(by: "join_map_files")?.text ?? ""
                var innerParsRegions = [Region]()
                var innerRegions = [Region]()
                if hasMap == "yes" {
                    _ = element[0]["region"].all.map { element in
                        let region = Region(
                            name: element.element?.attribute(by: "name")?.text ?? "",
                            flagImage: UIImage(named: "Flag")!,
                            downloadImage: UIImage(named: "Down_arrow")!)
                        innerParsRegions.append(region)
                        innerRegions = innerParsRegions.sorted(by: { $0.name < $1.name })
                    }
                }
                
                parceCountries.append(Country(
                    name: countryName,
                    regions: innerRegions,
                    flagImage: UIImage(named: "Flag")!,
                    downloadImage: UIImage(named: "Down_arrow")!,
                    moreImage: UIImage(named: "Arrow")!))
            }
        }
        
        countries = parceCountries.sorted(by: { $0.name < $1.name })
    }
    
    func selectCountry(with index: IndexPath) {
        selectedCellIndex = index
        let selectedCountry = countries[index.row]
        networkService.createURLForCountry(with: selectedCountry)
    }
    
    func updateDownloadProgress(progress: Double) {
        guard let index = selectedCellIndex?.row else { return }
        countries[index].downloadProgress = Float((progress))
    }
    
    func updateStateForCountry(with index: IndexPath) {
        countries[index.row].isMapDownload = true
    }
}

