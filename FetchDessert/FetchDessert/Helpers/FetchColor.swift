//
//  FetchColor.swift
//  FetchDessert
//
//  Created by Jerry Durkin on 1/10/23.
//

import UIKit

struct FetchColor {

    // Use red as default instead of force unwrap so its immediatly obivous when an asset is missing

    static let background = UIColor(named: "HomeBackground") ?? UIColor.red

    static let primary = UIColor(named: "AppPrimary") ?? UIColor.red

    static let white = UIColor.white

    static let clear = UIColor.clear

    static let black = UIColor.black

}
