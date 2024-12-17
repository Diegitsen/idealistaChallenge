//
//  PropertyCell.swift
//  idealistaChallenge
//
//  Created by diegitsen on 16/12/24.
//


import UIKit

class PropertyCell: UITableViewCell {
    
    var property: PropertyEntity?
    
    //MARK: - UI Components
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let carouselView: CarouselView = {
        let carousel = CarouselView()
        carousel.translatesAutoresizingMaskIntoConstraints = false
        return carousel
    }()
    let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Class Properties
    static let cellID = "PropertyCell"
    
    // MARK: - Class Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        container.dropShadow()
    }
    
    private func commonInit() {
        setupLayout()
        setupInteractions()
    }
    
    func setupLayout() {
        contentView.addSubview(container)
        container.addSubview(statusLabel)
        container.addSubview(carouselView)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            carouselView.topAnchor.constraint(equalTo: container.topAnchor),
            carouselView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            carouselView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            carouselView.heightAnchor.constraint(equalToConstant: 250),
            
            statusLabel.topAnchor.constraint(equalTo: carouselView.bottomAnchor, constant: 14),
            statusLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 14),
            statusLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -14),
            statusLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20)
        ])
        
        
    }
    
    func setupInteractions() {
        
    }
    
    func setupCell(property: PropertyEntity) {
     
        statusLabel.text = "  \(property.address)  "
        let picturesUrls = property.pictures.map { $0.url }
        carouselView.configure(with: picturesUrls)
    }
    
}
