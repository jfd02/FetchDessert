//
//  MealDataListModel.swift
//  FetchDessert
//
//  Created by Jerry Durkin on 1/11/23.
//

import Foundation

class MealDataListModel: Codable {

    let meals: [MealDataModel]

    enum CodingKeys: String, CodingKey {
        case meals
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        meals = try container.decode([MealDataModel].self, forKey: .meals)
    }
}
