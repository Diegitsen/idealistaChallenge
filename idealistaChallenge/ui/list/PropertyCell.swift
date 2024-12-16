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
    let carouselView: ImageCarouselView = {
        let carousel = ImageCarouselView()
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
            carouselView.heightAnchor.constraint(equalToConstant: 150),
            
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

///////----
///

// MARK: - ImageCarouselView
class ImageCarouselView: UIView {

    // MARK: - Properties
    private var imageUrls: [String] = []

    // MARK: - UI Components
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.8, height: 150)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCarouselCell.self, forCellWithReuseIdentifier: ImageCarouselCell.cellID)
        return collectionView
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupLayout() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: - Public Methods
    func configure(with imageUrls: [String]) {
        self.imageUrls = imageUrls
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension ImageCarouselView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCarouselCell.cellID, for: indexPath) as? ImageCarouselCell else {
            return UICollectionViewCell()
        }
        let imageUrl = imageUrls[indexPath.item]
        cell.configure(with: imageUrl)
        return cell
    }
}

// MARK: - ImageCarouselCell
class ImageCarouselCell: UICollectionViewCell {

    static let cellID = "ImageCarouselCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with imageUrl: String) {
        imageView.loadImage(from: imageUrl, placeholder: UIImage(named: "placeholder"))
    }
}
