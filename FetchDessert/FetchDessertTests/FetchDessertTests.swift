//
//  FetchDessertTests.swift
//  FetchDessertTests
//
//  Created by Jerry Durkin on 1/10/23.
//

import XCTest
@testable import FetchDessert

final class FetchDessertTests: XCTestCase {

    func testDessertListModel() throws {
        let testBundle = Bundle(for: type(of: self))
        let filePath = testBundle.path(forResource: "dessertData", ofType: "json")

        guard let filePath = filePath else {
            XCTFail("filePath is nil")
            return
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .mappedIfSafe)
            let returnValue = try JSONDecoder().decode(DessertListModel.self, from: data)
            XCTAssertTrue(type(of: returnValue) == DessertListModel.self)
        } catch {
            XCTFail("Decoding JSON failed")
          }
    }

    func testMealModel() throws {
        let testBundle = Bundle(for: type(of: self))
        let filePath = testBundle.path(forResource: "mealData", ofType: "json")

        guard let filePath = filePath else {
            XCTFail("filePath is nil")
            return
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .mappedIfSafe)
            let returnValue = try JSONDecoder().decode(MealDataListModel.self, from: data)
            XCTAssertTrue(type(of: returnValue) == MealDataListModel.self)
        } catch {
            XCTFail("Decoding JSON failed")
          }
    }
}
