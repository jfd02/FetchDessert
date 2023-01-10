//
//  BaseView.swift
//  FetchDessert
//
//  Created by Jerry Durkin on 1/10/23.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        layoutView()
        setupAccessibility()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupView()
        layoutView()
        setupAccessibility()
    }

    // Subclasses should override this method to add subviews.
    func setupView() {

    }

    // Subclasses should override this method to layout the view.
    func layoutView() {

    }

    // Subclasses should override this method to add accessibility.
    func setupAccessibility() {

    }

}
