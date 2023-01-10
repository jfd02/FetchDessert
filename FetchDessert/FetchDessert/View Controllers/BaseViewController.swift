//
//  BaseViewController.swift
//  FetchDessert
//
//  Created by Jerry Durkin on 1/10/23.
//

import UIKit

class BaseViewController<V: BaseView>: UIViewController {

    override func loadView() {
        view = V()
    }

    var customView: V {
        return view as! V
    }

}
