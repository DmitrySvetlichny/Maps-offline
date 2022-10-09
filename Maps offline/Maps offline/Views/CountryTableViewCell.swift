//
//  CountryTableViewCell.swift
//  Maps offline
//
//  Created by ДМИТРИЙ СВЕТЛИЧНЫЙ on 02.10.2022.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    var indexPath: IndexPath = IndexPath()
    var didTapDownloadOrMoreImageView: ((IndexPath) -> Void)?
    
    let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let countryNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Roboto-Medium", size: 17)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let downloadOrMoreImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let dividingLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue:240/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let downloadProgressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.setProgress(0.5, animated: false)
        progressView.tintColor = UIColor(red: 255/255, green: 136/255, blue: 0/255, alpha: 1)
        return progressView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapDownloadOrMoreImageView))
        downloadOrMoreImageView.addGestureRecognizer(tapGesture)
        contentView.addSubviews(views: [flagImageView, countryNameLabel, downloadOrMoreImageView, dividingLineView, downloadProgressView])
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        directionalLayoutMargins = .zero
        selectionStyle = .none
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            flagImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 19),
            flagImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
            flagImageView.widthAnchor.constraint(equalToConstant: 25),
            flagImageView.heightAnchor.constraint(equalToConstant: 25)
        ])
        NSLayoutConstraint.activate([
            countryNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 19),
            countryNameLabel.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor, constant: 27)
        ])
        NSLayoutConstraint.activate([
            downloadOrMoreImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 19),
            downloadOrMoreImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -23),
            downloadOrMoreImageView.widthAnchor.constraint(equalToConstant: 25),
            downloadOrMoreImageView.heightAnchor.constraint(equalToConstant: 25)
        ])
        NSLayoutConstraint.activate([
            downloadProgressView.topAnchor.constraint(equalTo: countryNameLabel.bottomAnchor, constant: 2),
            downloadProgressView.trailingAnchor.constraint(equalTo: downloadOrMoreImageView.leadingAnchor),
            downloadProgressView.leadingAnchor.constraint(equalTo: countryNameLabel.leadingAnchor),
            downloadProgressView.heightAnchor.constraint(equalToConstant: 2)
        ])
        NSLayoutConstraint.activate([
            dividingLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dividingLineView.leadingAnchor.constraint(equalTo: countryNameLabel.leadingAnchor),
            dividingLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dividingLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func populate(with country: Country) {
        countryNameLabel.text = country.name.capitalized
        flagImageView.image = country.flagImage
        if country.regions.count > 0 {
            downloadOrMoreImageView.image = country.moreImage
        } else {
            downloadOrMoreImageView.image = country.downloadImage
        }
        
        downloadProgressView.setProgress(country.downloadProgress, animated: true)
        downloadProgressView.isHidden = country.isMapDownload
        if country.isMapDownload {
            downloadOrMoreImageView.isHidden = true
            flagImageView.withColor(color: .systemGreen)
        }
    }
    
    func populateRegionCell(with region: Region) {
        countryNameLabel.text = region.name.capitalized
        flagImageView.image = region.flagImage
        downloadOrMoreImageView.image = region.downloadImage
        downloadProgressView.setProgress(region.downloadProgress, animated: true)
        downloadProgressView.isHidden = region.isMapDownload
        if region.isMapDownload {
            downloadOrMoreImageView.isHidden = true
            flagImageView.withColor(color: .systemGreen)
        }
    }
    
    @objc func tapDownloadOrMoreImageView() {
        didTapDownloadOrMoreImageView?(indexPath)
    }
    
    override func prepareForReuse() {
        downloadProgressView.setProgress(0, animated: false)
        flagImageView.image = UIImage(named: "Flag")
    }
}
