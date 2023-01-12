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
        label.font = FetchFont.bold(size: 14)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.textColor = FetchColor.black
        return label
    }()

    private let seeMoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = FetchColor.primary
        label.numberOfLines = 1
        label.text = "See recipe"
        label.font = FetchFont.medium(size: 12)
        return label
    }()

    private let textMargins = UILayoutGuide()

    private func setupView() {
        contentView.addLayoutGuide(textMargins)
        contentView.addSubview(dessertImage)
        contentView.addSubview(dessertLabel)
        contentView.addSubview(seeMoreLabel)

        contentView.backgroundColor = FetchColor.background
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false

        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.10
        layer.shadowColor = FetchColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }

    private func layoutView() {
        dessertImage.setContentHuggingPriority(.defaultLow, for: .vertical)
        dessertImage.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        NSLayoutConstraint.activate([
            textMargins.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            textMargins.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),

            dessertImage.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            dessertImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            dessertImage.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            dessertImage.bottomAnchor.constraint(equalTo: dessertLabel.topAnchor, constant: -8),

            dessertLabel.leadingAnchor.constraint(equalTo: textMargins.leadingAnchor),
            dessertLabel.trailingAnchor.constraint(equalTo: textMargins.trailingAnchor),
            dessertLabel.bottomAnchor.constraint(equalTo: self.seeMoreLabel.topAnchor, constant: -8),

            seeMoreLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            seeMoreLabel.leadingAnchor.constraint(equalTo: textMargins.leadingAnchor),
            seeMoreLabel.trailingAnchor.constraint(equalTo: textMargins.trailingAnchor)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // Improve scrolling performance with an explicit shadowPath
        // https://developer.apple.com/documentation/quartzcore/calayer/1410771-shadowpath
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
    }

    override func prepareForReuse() {
        dessertLabel.text = ""
        dessertImage.image = nil
    }
}
