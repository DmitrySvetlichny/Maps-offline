//
//  MainView.swift
//  Maps offline
//
//  Created by ДМИТРИЙ СВЕТЛИЧНЫЙ on 30.09.2022.
//

import UIKit

class MainView: UIView {
    
    let deviceMemoryView: DeviceMemoryView = {
        let memoryView = DeviceMemoryView()
        memoryView.translatesAutoresizingMaskIntoConstraints = false
        return memoryView
    }()
    
    let countryTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutMainView()
        setupInfoConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutMainView() {
        backgroundColor = UIColor(red: 242, green: 242, blue: 243, alpha: 1)
        addSubviews(views: [deviceMemoryView, countryTableView])
        countryTableView.register(CountryTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupInfoConstraints() {
        NSLayoutConstraint.activate([
            deviceMemoryView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            deviceMemoryView.leadingAnchor.constraint(equalTo: leadingAnchor),
            deviceMemoryView.trailingAnchor.constraint(equalTo: trailingAnchor),
            deviceMemoryView.heightAnchor.constraint(equalToConstant: 64)
        ])
        NSLayoutConstraint.activate([
            countryTableView.topAnchor.constraint(equalTo: deviceMemoryView.bottomAnchor),
            countryTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            countryTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            countryTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setDeviceMemoryInfo(data: DeviceMemoryData) {
        deviceMemoryView.setMemoryInfo(data: data)
    }
}
