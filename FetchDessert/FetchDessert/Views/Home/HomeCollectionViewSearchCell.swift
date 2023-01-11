//
//  HomeCollectionViewSearchCell.swift
//  FetchDessert
//
//  Created by Jerry Durkin on 1/10/23.
//

import UIKit

protocol HomeCollectionViewSearchCellDelegate: AnyObject {
    func didSearch(text: String)
}

class HomeCollectionViewSearchCell: UICollectionReusableView {
    
    weak var delegate: HomeCollectionViewSearchCellDelegate?
    
    static var identifier = "HomeCollectionViewSearchCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let searchBar: SearchBar = {
        let label = SearchBar()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupView() {
        self.backgroundColor = FetchColor.background
        self.addSubview(searchBar)
        searchBar.delegate = self
    }
    
    private func layoutView() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            searchBar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
    }
}

extension HomeCollectionViewSearchCell: SearchBarDelegate {
    func didSearch(text: String) {
        delegate?.didSearch(text: text)
    }
}
