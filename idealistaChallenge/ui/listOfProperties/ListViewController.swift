//
//  ListViewController.swift
//  idealistaChallenge
//
//  Created by diegitsen on 15/12/24.
//

import UIKit

class ListViewController: UIViewController, MainProtocol {
    
    let viewModel = ListViewModel()
    
    // MARK: - UI Components
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let listTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    let filterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        stackView.axis = .horizontal
        return stackView
    }()
    let filterView: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let filterImageView: UIImageView = {
            let image = UIImageView()
            image.image = UIImage(systemName: "line.3.horizontal.decrease.circle")
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()
        
        button.addSubview(filterImageView)
        
        NSLayoutConstraint.activate([
            filterImageView.heightAnchor.constraint(equalToConstant: 20),
            filterImageView.widthAnchor.constraint(equalToConstant: 20),
            filterImageView.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 5),
            filterImageView.topAnchor.constraint(equalTo: button.topAnchor, constant: 5),
            filterImageView.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -5),
            filterImageView.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -5)
        ])
        
        return button
    }()
    let dateFilterView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let calendarImageView: UIImageView = {
            let image = UIImageView()
            image.image = UIImage(systemName: "calendar")
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()
        let dateLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.text = "Fecha"
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        view.addSubview(calendarImageView)
        view.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            calendarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            calendarImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            calendarImageView.heightAnchor.constraint(equalToConstant: 20),
            calendarImageView.widthAnchor.constraint(equalToConstant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: calendarImageView.trailingAnchor, constant: 5),
            dateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            dateLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
        
        return view
    }()
    let typeFilterView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let calendarImageView: UIImageView = {
            let image = UIImageView()
            image.image = UIImage(systemName: "book.closed")
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()
        let dateLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.text = "Tipo"
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        view.addSubview(calendarImageView)
        view.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            calendarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            calendarImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            calendarImageView.heightAnchor.constraint(equalToConstant: 20),
            calendarImageView.widthAnchor.constraint(equalToConstant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: calendarImageView.trailingAnchor, constant: 5),
            dateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            dateLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
        
        return view
    }()
    let statusFilterView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let calendarImageView: UIImageView = {
            let image = UIImageView()
            image.image = UIImage(systemName: "pencil")
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()
        let dateLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.text = "Estado"
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        view.addSubview(calendarImageView)
        view.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            calendarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            calendarImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            calendarImageView.heightAnchor.constraint(equalToConstant: 20),
            calendarImageView.widthAnchor.constraint(equalToConstant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: calendarImageView.trailingAnchor, constant: 5),
            dateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            dateLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
        
        return view
    }()
    
    // MARK: - View Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupConstraints()
        setupInteractions()
        setupTableView()
        setupViews()
        setupSortButtonMenu()
        setupObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.viewModel.performanceServiceResponse.value = nil
       
        setupData()
    }
    
    override func viewWillLayoutSubviews() {
        dateFilterView.dropShadow()
        filterView.dropShadow()
        typeFilterView.dropShadow()
        statusFilterView.dropShadow()
    }
    
    func setupViews() {
        title = "Lista"
        
        if let navigationBar = self.navigationController?.navigationBar {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
//            appearance.backgroundColor = .mainColor
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
            navigationBar.tintColor = .white
        }
    }
    
    func setupLayout() {
        view.addSubview(containerView)
        
        containerView.addSubview(listTableView)
        containerView.addSubview(filterStackView)
        
        filterStackView.addArrangedSubview(filterView)
        filterStackView.addArrangedSubview(dateFilterView)
        filterStackView.addArrangedSubview(typeFilterView)
        filterStackView.addArrangedSubview(statusFilterView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            filterStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            filterStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            listTableView.topAnchor.constraint(equalTo: filterStackView.bottomAnchor, constant: 10),
            listTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            listTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            listTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
        ])
    }
    
    func setupInteractions() {
        let tapGestureDate = UITapGestureRecognizer(target: self, action: #selector(filterByDate))
        dateFilterView.isUserInteractionEnabled = true
        dateFilterView.addGestureRecognizer(tapGestureDate)
        
        let tapGestureType = UITapGestureRecognizer(target: self, action: #selector(filterByType))
        typeFilterView.isUserInteractionEnabled = true
        typeFilterView.addGestureRecognizer(tapGestureType)
        
        let tapGestureStatus = UITapGestureRecognizer(target: self, action: #selector(filterByStatus))
        statusFilterView.isUserInteractionEnabled = true
        statusFilterView.addGestureRecognizer(tapGestureStatus)
    }
    
    func setupData() {
        getListOfProperties()
    }

    
    private func setupObservers() {
  
        viewModel.properties.observe = { properties in
            self.dateFilterView.layer.borderWidth = 0
            self.typeFilterView.layer.borderWidth = 0
            self.statusFilterView.layer.borderWidth = 0
            
            self.listTableView.reloadData()
        }
    }
    
    func getListOfProperties() {
        Task {
            self.viewModel.properties.value = nil
            await viewModel.getListOfProperties()
        }
    }

    func setupSortButtonMenu() {
        let children = fetchSortButtonMenuChilder()
        let menu = UIMenu(children: children)
        filterView.menu = menu
        filterView.showsMenuAsPrimaryAction = true
    }
    
    private func fetchSortButtonMenuChilder() -> [UIAction] {
        let sortRecentIcon = true ? UIImage(systemName: "checkmark") : nil
        let sortOldestIcon = !true ? UIImage(systemName: "checkmark") : nil
        let children = [
            UIAction(title: "Más recientes", image: sortRecentIcon, handler: { _ in
//                self.viewModel.performances.value = nil
//                self.viewModel.getPerformances(sortOption: SortOption.NEWEST)
//                self.sortPerformancesByNewest = true
                self.setupSortButtonMenu()
            }),
            UIAction(title: "Más antiguos", image: sortOldestIcon, handler: { _ in
//                self.viewModel.performances.value = nil
//                self.viewModel.getPerformances(sortOption: SortOption.OLDEST)
//                self.sortPerformancesByNewest = false
                self.setupSortButtonMenu()
            })
        ]
        return children
    }
    
 

    @objc func filterByDate() {
//        if dateFilterView.isSelected() {
//            dateFilterView.layer.borderWidth = 0
//            filters.initDate = nil
//            filters.endDate = nil
//            viewModel.filterPerformances(filters: filters)
//        } else {
//            let dateRangeSheetViewController = DateRangeSheetViewController()
//            dateRangeSheetViewController.delegate = self
//            self.present(dateRangeSheetViewController, animated: true)
//        }
    }
    
    @objc func filterByType() {
//        if typeFilterView.isSelected() {
//            typeFilterView.layer.borderWidth = 0
//            filters.type = nil
//            viewModel.filterPerformances(filters: filters)
//        } else {
//            let filterPerformancesSheetViewController = FilterPerformancesSheetViewController()
//            filterPerformancesSheetViewController.filterType = .TYPE
//            filterPerformancesSheetViewController.selectPerformanceTypeCallback = { type in
//                self.typeFilterView.layer.borderWidth = Constants.VIEW_SELECTED_BORDER_WIDTH
//                self.typeFilterView.layer.borderColor = UIColor.darkGray.cgColor
//                self.filters.type = type
//                self.viewModel.filterPerformances(filters: self.filters)
//            }
//            self.present(filterPerformancesSheetViewController, animated: true)
//        }
    }
    
    @objc func filterByStatus() {
//        if statusFilterView.isSelected() {
//            statusFilterView.layer.borderWidth = 0
//            filters.status = nil
//            viewModel.filterPerformances(filters: filters)
//        } else {
//            let filterPerformancesSheetViewController = FilterPerformancesSheetViewController()
//            filterPerformancesSheetViewController.filterType = .STATUS
//            filterPerformancesSheetViewController.selectPerformanceStatusCallback = {
//                status in
//                self.statusFilterView.layer.borderWidth = Constants.VIEW_SELECTED_BORDER_WIDTH
//                self.statusFilterView.layer.borderColor = UIColor.darkGray.cgColor
//                self.filters.status = status
//                self.viewModel.filterPerformances(filters: self.filters)
//            }
//            self.present(filterPerformancesSheetViewController, animated: true)
//        }
    }
}
