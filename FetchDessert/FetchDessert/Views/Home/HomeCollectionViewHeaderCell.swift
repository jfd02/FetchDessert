//
//  HomeCollectionViewHeaderCell.swift
//  FetchDessert
//
//  Created by Jerry Durkin on 1/10/23.
//

import UIKit

class HomeCollectionViewHeaderCell: UICollectionReusableView {
    
    static var identifier = "HomeCollectionViewHeaderCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Fetch\nDesserts"
        label.textColor = FetchColor.primary
        label.font = FetchFont.black(size: 35)
        label.numberOfLines = 0
        return label
    }()
    
    private func setupView() {
        self.addSubview(headerLabel)
    }
    
    private func layoutView() {
        let cellBottomAnchor: NSLayoutConstraint
        cellBottomAnchor = self.bottomAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15)
        cellBottomAnchor.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            cellBottomAnchor,
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15)
        ])
    }
    
}
