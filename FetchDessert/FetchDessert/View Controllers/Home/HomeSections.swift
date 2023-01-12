//
//  HomeSections.swift
//  FetchDessert
//
//  Created by Jerry Durkin on 1/11/23.
//

enum HomeSections: Int {
    case header = 0
    case search = 1
    case desserts = 2

    private static let allValues = [header, search, desserts]
    static let count = allValues.count
}
