//
//  HomeView.swift
//  FetchDessert
//
//  Created by Jerry Durkin on 1/10/23.
//

import UIKit

final class HomeView: BaseView {
    
    internal let homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.backgroundColor = .clear
        collectionView.register(DessertCollectionViewCell.self,
                                                    forCellWithReuseIdentifier: DessertCollectionViewCell.identifier)
        collectionView.register(HomeCollectionViewHeaderCell.self,
                                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                                    withReuseIdentifier: HomeCollectionViewHeaderCell.identifier)
        collectionView.register(HomeCollectionViewSearchCell.self,
                                                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                                    withReuseIdentifier: HomeCollectionViewSearchCell.identifier)
        return collectionView
    }()
    
    override func setupView() {
        self.backgroundColor = FetchColor.background
        self.addSubview(homeCollectionView)
    }
    
    override func layoutView() {
        NSLayoutConstraint.activate([
            homeCollectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            homeCollectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            homeCollectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            homeCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }

}
