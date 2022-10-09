//
//  ViewController.swift
//  Maps offline
//
//  Created by ДМИТРИЙ СВЕТЛИЧНЫЙ on 30.09.2022.
//

import UIKit
import SWXMLHash

class MainViewController: UIViewController {
    
    var rootView: MainView { view as! MainView }
    let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = MainView()
        rootView.countryTableView.delegate = self
        rootView.countryTableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.setDeviceMemoryInfo(data: viewModel.getDeviceMemoryData())
        viewModel.progressCallBack = { progress, index in
            self.viewModel.updateDownloadProgress(progress: progress)
            self.rootView.countryTableView.reloadRows(at: [index], with: .none)
        }
        
        viewModel.completion = { index in
            self.viewModel.updateStateForCountry(with: index)
            self.rootView.countryTableView.reloadRows(at: [index], with: .none)
        }
        
        viewModel.parseXml()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Download Maps"
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(red: 255/255, green: 136/255, blue: 0/255, alpha: 1)
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)]
        navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.title = ""
    }
    
    func goToDetailViewController(with country: Country) {
        let detailedVC = ViewControllerFactory.makeDetailedViewController(country: country)
        navigationController?.pushViewController(detailedVC, animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "EUROPE"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CountryTableViewCell else { return UITableViewCell() }
        cell.didTapDownloadOrMoreImageView = { cellIndex in
            let country = self.viewModel.countries[cellIndex.row]
            if country.regions.isEmpty {
                self.viewModel.selectCountry(with: indexPath)
            } else {
                self.goToDetailViewController(with: country)
            }
        }
        
        let country = viewModel.countries[indexPath.row]
        cell.populate(with: country)
        rootView.countryTableView.reloadRows(at: [indexPath], with: .none)
        cell.indexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        52
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let country = viewModel.countries[indexPath.row]
        if !country.regions.isEmpty {
            goToDetailViewController(with: country)
        }
    }
}

