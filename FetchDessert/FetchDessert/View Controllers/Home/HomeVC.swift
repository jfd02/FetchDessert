//
//  HomeVC.swift
//  FetchDessert
//
//  Created by Jerry Durkin on 1/10/23.
//

import Foundation
import UIKit

final class HomeVC: BaseViewController<HomeView> {

    private var desserts: [DessertModel] = [] {
        didSet {
            self.filteredDesserts = desserts
        }
    }

    private var filteredDesserts: [DessertModel] = []

    private let minimumLineSpacingForSectionAt: CGFloat = 15.0

    private let minimumInteritemSpacingForSectionAt: CGFloat = 7.0

    private let itemsPerRow: Int = 2

    private var loadingMealView: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.customView.homeCollectionView.dataSource = self
        self.customView.homeCollectionView.delegate = self
        getDesserts()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension HomeVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HomeSections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch HomeSections(rawValue: section) {
        case .desserts:
            return filteredDesserts.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch HomeSections(rawValue: indexPath.section) {
        case .desserts:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DessertCollectionViewCell.identifier,
                                                             for: indexPath) as? DessertCollectionViewCell {
                cell.dessert = desserts[indexPath.row]
                return cell
            }
        default:
            break
        }
        // This would cause a crash if it gets hit, but it means we made a logic error elsewhere.
        return UICollectionViewCell()
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch HomeSections(rawValue: indexPath.section) {
        case .desserts:
            let width = collectionView.frame.width / CGFloat(itemsPerRow)
            let widthMinusSpacing = width - minimumLineSpacingForSectionAt - minimumInteritemSpacingForSectionAt
            return CGSize(width: widthMinusSpacing, height: width * 1.2)
        default:
            return CGSize(width: 0, height: 0)
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch HomeSections(rawValue: section) {
        case .desserts:
            return minimumLineSpacingForSectionAt
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch HomeSections(rawValue: section) {
        case .desserts:
            return minimumInteritemSpacingForSectionAt
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        switch HomeSections(rawValue: section) {
        case .desserts:
            return UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch HomeSections(rawValue: indexPath.section) {
        case .header:
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                       withReuseIdentifier: HomeCollectionViewHeaderCell.identifier,
                                                                       for: indexPath)
            return cell
        case .search:
            if let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                          withReuseIdentifier: HomeCollectionViewSearchCell.identifier,
                                                                          for: indexPath) as? HomeCollectionViewSearchCell {
                cell.delegate = self
                return cell
            }
        default:
            break
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch HomeSections(rawValue: section) {
        case .header:
            let headerView = self.collectionView(collectionView,
                                                 viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader,
                                                 at: IndexPath(row: 0, section: section))
            return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                             height: UIView.layoutFittingExpandedSize.height),
                                                      withHorizontalFittingPriority: .required,
                                                      verticalFittingPriority: .fittingSizeLevel)
        case .search:
            return CGSize(width: collectionView.frame.width, height: 50)
        default:
            return CGSize(width: 0, height: 0)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if loadingMealView { return }
        loadingMealView = true
        
        switch HomeSections(rawValue: indexPath.section) {
        case .desserts:
            let dessert = filteredDesserts[indexPath.row]
            API.getMeal(mealID: dessert.mealID, onSuccess: { data in
                DispatchQueue.main.async {
                    HapticGenerator.light()
                    let mealVC = MealVC(meal: data)
                    self.navigationController?.pushViewController(mealVC, animated: true)
                    self.loadingMealView = false
                }
            }, onFailure: { _ in
                HapticGenerator.error()
                logger.info("Handle error here")
            })
        default:
            return
        }
    }
}

extension HomeVC {
    private func getDesserts() {
        API.getDesserts(onSuccess: { data in
            self.desserts = data.sorted(by: { $0.mealName < $1.mealName })
            DispatchQueue.main.async {
                self.customView.homeCollectionView.reloadSections(IndexSet(integer: HomeSections.desserts.rawValue))
            }
        }, onFailure: { _ in
            HapticGenerator.error()
            logger.info("Handle error here")
        })
    }
}

extension HomeVC: HomeCollectionViewSearchCellDelegate {
    func didSearch(text: String) {
        filteredDesserts = desserts
        if !text.isEmpty {
            filteredDesserts = filteredDesserts.filter({ $0.mealName.contains(text) })
        }
        self.customView.homeCollectionView.reloadSections(IndexSet(integer: HomeSections.desserts.rawValue))
    }
}
