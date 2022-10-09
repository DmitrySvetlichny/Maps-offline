//
//  NetworkService.swift
//  Maps offline
//
//  Created by ДМИТРИЙ СВЕТЛИЧНЫЙ on 06.10.2022.
//

import Foundation

class NetworkService: NSObject {
    
    var currentDownload: Int64 = -1
    let baseURL = "http://download.osmand.net/download.php?standard=yes&file="
    let extensionURL = "_europe_2.obf.zip"
    var progressCallBack: ((Double) -> Void)?
    var completion: (() -> Void)?
    
    func createURLForCountry(with country: Country) {
        let nameCountry = country.name.capitalized
        guard let url = URL(string: baseURL + nameCountry + extensionURL) else { return }
        downloadFile(with: url)
    }
    
    func createURLForRegion(with region: Region, country: Country) {
        let nameCountry = country.name.capitalized + "_"
        let nameRegion = region.name
        guard let url = URL(string: baseURL + nameCountry + nameRegion + extensionURL) else { return }
        downloadFile(with: url)
    }
    
    func downloadFile(with url: URL) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        let task = session.downloadTask(with: url)
        task.resume()
    }
}

extension NetworkService: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        DispatchQueue.main.async {
            self.completion?()
        }
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64,
                           totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) -> Void {
        let percentage = Double(totalBytesWritten)/Double(totalBytesExpectedToWrite)
        DispatchQueue.main.async {
            self.progressCallBack?(percentage)
        }
    }
}
