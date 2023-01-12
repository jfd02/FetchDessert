//
//  FetchFont.swift
//  FetchDessert
//
//  Created by Jerry Durkin on 1/10/23.
//

import UIKit

struct FetchFont {

    static func bold(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }

    static func black(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .black)
    }

    static func medium(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }

}
