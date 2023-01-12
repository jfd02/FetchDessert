//
//  DessertListModel.swift
//  FetchDessert
//
//  Created by Jerry Durkin on 1/11/23.
//

import Foundation

class DessertListModel: Codable {

    let meals: [DessertModel]

    enum CodingKeys: String, CodingKey {
        case meals
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        meals = try container.decode([DessertModel].self, forKey: .meals)
    }
}
