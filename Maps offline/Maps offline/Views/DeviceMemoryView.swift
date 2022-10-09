//
//  DeviceMemoryView.swift
//  Maps offline
//
//  Created by ДМИТРИЙ СВЕТЛИЧНЫЙ on 30.09.2022.
//

import UIKit

class DeviceMemoryView: UIView {
    
    let deviceMemoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Device memory"
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let freeMemoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let memoryProgressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.layer.cornerRadius = 8
        progressView.clipsToBounds = true
        progressView.layer.sublayers![1].cornerRadius = 8
        progressView.subviews[1].clipsToBounds = true
        progressView.tintColor = UIColor(red: 255/255, green: 136/255, blue: 0/255, alpha: 1)
        progressView.trackTintColor = UIColor(red: 240/255, green: 240/255, blue:240/255, alpha: 1)
        return progressView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutDeviceMemoryView()
        setupInfoConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutDeviceMemoryView() {
        backgroundColor = .white
        addSubviews(views: [deviceMemoryLabel, freeMemoryLabel, memoryProgressView])
    }
    
    private func setupInfoConstraints() {
        NSLayoutConstraint.activate([
            deviceMemoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            deviceMemoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        ])
        NSLayoutConstraint.activate([
            freeMemoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            freeMemoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
        NSLayoutConstraint.activate([
            memoryProgressView.topAnchor.constraint(equalTo: deviceMemoryLabel.bottomAnchor, constant: 9),
            memoryProgressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            memoryProgressView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            memoryProgressView.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func setMemoryInfo(data: DeviceMemoryData) {
        freeMemoryLabel.text = String(format: "Free %@", data.freeSpace)
        memoryProgressView.setProgress(data.progresValue, animated: false)
    }
}
