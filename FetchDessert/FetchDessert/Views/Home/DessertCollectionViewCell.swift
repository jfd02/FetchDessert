//
//  DessertCollectionViewCell.swift
//  FetchDessert
//
//  Created by Jerry Durkin on 1/10/23.
//

import UIKit

class DessertCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "DessertCollectionViewCell"
    
    private let cornerRadius: CGFloat = 5.0
    
    var dessert: DessertModel? {
        didSet {
            guard let dessert = dessert else { return }
            dessertLabel.text = dessert.mealName
            if dessert.image != nil {
                dessertImage.image = dessert.image
            } else {
                if let url = URL(string: dessert.mealImageStr) {
                    dessertImage.load(url: url, completion: { image in
                        dessert.image = image
                    })
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let dessertImage: RemoteImageView = {
        let remoteImage = RemoteImageView()
        remoteImage.translatesAutoresizingMaskIntoConstraints = false
        remoteImage.contentMode = .scaleAspectFill
        remoteImage.clipsToBounds = true
        return remoteImage
    }()
    
    private let dessertLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FetchFont.bold(size: 13)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private func setupView() {
        contentView.addSubview(dessertImage)
        contentView.addSubview(dessertLabel)
        contentView.backgroundColor = FetchColor.background
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    private func layoutView() {
        NSLayoutConstraint.activate([
            dessertImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            dessertImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            dessertImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            dessertImage.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.7),
            
            dessertLabel.topAnchor.constraint(equalTo: dessertImage.bottomAnchor, constant: 5),
            dessertLabel.leadingAnchor.constraint(equalTo: dessertImage.leadingAnchor, constant: 5),
            dessertLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Improve scrolling performance with an explicit shadowPath https://developer.apple.com/documentation/quartzcore/calayer/1410771-shadowpath
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
    }
    
    override func prepareForReuse() {
        dessertLabel.text = ""
        dessertImage.image = nil
    }
        
}
