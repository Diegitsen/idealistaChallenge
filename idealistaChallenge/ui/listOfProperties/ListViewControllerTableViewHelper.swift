//
//  ListViewControllerTableViewHelper.swift
//  idealistaChallenge
//
//  Created by diegitsen on 17/12/24.
//

import UIKit

// MARK: - CollectionView Setup Methods

extension ListViewController {

    func setupTableView() {
        setupCollectionViewDelegateAndDataSource()
        registerCollectionViewCells()
    }

    private func setupCollectionViewDelegateAndDataSource() {
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.rowHeight = UITableView.automaticDimension
        listTableView.separatorStyle = .none
    }

    private func registerCollectionViewCells() {
        listTableView.register(PropertyCell.self, forCellReuseIdentifier: PropertyCell.cellID)
    }

}

// MARK: - CollectionView DataSource and Delegate Methods

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.properties.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyCell.cellID) as! PropertyCell
        guard let properties = viewModel.properties.value else {
            return cell
        }
        let property = properties[indexPath.row]
        cell.selectionStyle = .none
        cell.setupCell(property: property)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let property = viewModel.properties.value?[indexPath.row] else {
            return
        }
        let propertyDetailViewController = PropertyDetailViewController()
        self.navigationController?.pushViewController(propertyDetailViewController, animated: true)
        //TODO: create a router
//        let vc = PerformanceDetailViewController()
//        vc.performance = performance
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}

