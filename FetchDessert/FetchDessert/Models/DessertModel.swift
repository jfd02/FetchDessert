//
//  DessertModel.swift
//  FetchDessert
//
//  Created by Jerry Durkin on 1/10/23.
//

import Foundation
import UIKit

class DessertModel: Codable {
    
    let mealName: String
    let mealImageStr: String
    let mealID: String
    
    var image: UIImage? = nil // Cache image in data model so we don't have to fetch multiple times.
    
    enum CodingKeys: String, CodingKey {
        case mealName = "strMeal"
        case mealImageStr = "strMealThumb"
        case mealID = "idMeal"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mealName = try container.decode(String.self, forKey: .mealName)
        mealImageStr = try container.decode(String.self, forKey: .mealImageStr)
        mealID = try container.decode(String.self, forKey: .mealID)
    }
    
}
