//
//  DetailedView.swift
//  Maps offline
//
//  Created by ДМИТРИЙ СВЕТЛИЧНЫЙ on 01.10.2022.
//

import UIKit

class DetailedView: UIView {
    
    let regionsTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutDetailedView()
        setupInfoConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutDetailedView() {
        backgroundColor = UIColor(red: 242, green: 242, blue: 243, alpha: 1)
        addSubview(regionsTableView)
        regionsTableView.register(CountryTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setupInfoConstraints() {
        NSLayoutConstraint.activate([
            regionsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            regionsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            regionsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            regionsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
