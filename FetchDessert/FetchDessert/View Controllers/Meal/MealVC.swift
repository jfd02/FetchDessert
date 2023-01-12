//
//  MealVC.swift
//  FetchDessert
//
//  Created by Jerry Durkin on 1/10/23.
//

import Foundation
import UIKit

class MealVC: BaseViewController<MealView> {

    init(meal: MealDataModel) {
        super.init(nibName: nil, bundle: nil)
        self.customView.meal = meal
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithTransparentBackground()
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
    }
}
