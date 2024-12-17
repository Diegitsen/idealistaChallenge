//
//  PropertyDetailViewController.swift
//  idealistaChallenge
//
//  Created by diegitsen on 17/12/24.
//

import UIKit

class PropertyDetailViewController: UIViewController, MainProtocol {
    
    // MARK: - UI Components
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let xeagaImageView: UILabel = {
        let image = UILabel()
        image.text = "Detail"
        image.font = .boldSystemFont(ofSize: 22)
//        image.textColor = .mainColor
        image.numberOfLines = 0
        image.textAlignment = .center
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupConstraints()
        setupInteractions()
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupData()
    }
    
    func setupLayout() {
        view.addSubview(containerView)
        
        containerView.addSubview(xeagaImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            xeagaImageView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 50),
            xeagaImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30),
            xeagaImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
        ])
    }
    
    func setupInteractions() {
        
    }
    
    func setupData() {
        
    }
    
    func setupViews() {
        title = "Detalle"
        
//        let user = PersistenceManager.shared.fetch(User.self).first
//        nifValueLabel.text = user?.nif ?? ""
//        exploitationCodeValueLabel.text = user?.exploitationId ?? ""
//
//        if let navigationBar = self.navigationController?.navigationBar {
//            let appearance = UINavigationBarAppearance()
//            appearance.configureWithOpaqueBackground()
//            appearance.backgroundColor = .mainColor
//            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//
//            navigationBar.standardAppearance = appearance
//            navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
//            navigationBar.tintColor = .white
//        }
        
//        setupChangeLanguageButtonMenu()
    }
}
