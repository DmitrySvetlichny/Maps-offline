//
//  DetailedViewController.swift
//  Maps offline
//
//  Created by ДМИТРИЙ СВЕТЛИЧНЫЙ on 01.10.2022.
//

import UIKit

class DetailedViewController: UIViewController {
    
    var rootView: DetailedView { view as! DetailedView }
    let viewModel: DetailedViewModel
    
    init(viewModel: DetailedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = DetailedView()
        rootView.regionsTableView.delegate = self
        rootView.regionsTableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.progressCallBack = { progress, index in
            self.viewModel.updateDownloadProgress(progress: progress)
            self.rootView.regionsTableView.reloadRows(at: [index], with: .none)
        }
        
        viewModel.completion = { index in
            self.viewModel.updateStateForRegion(with: index)
            self.rootView.regionsTableView.reloadRows(at: [index], with: .none)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = viewModel.title
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(red: 255/255, green: 136/255, blue: 0/255, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)]
        navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

extension DetailedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "REGIONS"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.country.regions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CountryTableViewCell else { return UITableViewCell() }
        cell.didTapDownloadOrMoreImageView = { cellIndex in
            self.viewModel.selectRegion(with: cellIndex)
        }
        
        let regions = viewModel.country.regions[indexPath.row]
        cell.populateRegionCell(with: regions)
        rootView.regionsTableView.reloadRows(at: [indexPath], with: .none)
        cell.indexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        52
    }
}
