//
//  APIClient.swift
//  FetchDessert
//
//  Created by Jerry Durkin on 1/10/23.
//

import UIKit
import Foundation

class API {
    enum HTTPMethod: String {
        case get
    }

    static let baseURL = "https://themealdb.com/api/json/v1/1/"
    static func getDesserts(onSuccess: @escaping (_ response: [DessertModel]) -> Void,
                            onFailure: @escaping (_ error: Error?) -> Void) {

        var request = URLRequest(url: URL(string: baseURL + "filter.php?c=Dessert")!)
        request.httpMethod = HTTPMethod.get.rawValue
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, _, error -> Void in
            guard let data = data else {
                logger.error("Error took place \(error.debugDescription).")
                onFailure(error)
                return
            }
            do {
                let returnValue = try JSONDecoder().decode(DessertListModel.self, from: data)
                onSuccess(returnValue.meals)
                return
            } catch {
                logger.error("Decoding Error took place \(error.localizedDescription).")
            }
            onFailure(error)
        })
        task.resume()
    }

    static func getMeal(mealID: String,
                        onSuccess: @escaping (_ response: MealDataModel) -> Void,
                        onFailure: @escaping (_ error: Error?) -> Void) {

        var request = URLRequest(url: URL(string: baseURL + "lookup.php?i=\(mealID)")!)
        request.httpMethod = HTTPMethod.get.rawValue

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, _, error -> Void in
            guard let data = data else {
                logger.error("Error took place \(error.debugDescription).")
                onFailure(error)
                return
            }

            do {
                let returnValue = try JSONDecoder().decode(MealDataListModel.self, from: data)
                if let meal = returnValue.meals.first {
                    onSuccess(meal)
                    return
                }
            } catch {
                logger.error("Decoding Error took place \(error.localizedDescription).")
            }
            onFailure(error)
        })
        task.resume()
    }
}
