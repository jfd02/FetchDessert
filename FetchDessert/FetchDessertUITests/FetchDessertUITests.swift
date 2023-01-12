//
//  FetchDessertUITests.swift
//  FetchDessertUITests
//
//  Created by Jerry Durkin on 1/10/23.
//

import XCTest

final class FetchDessertUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testCollectionViewExists() throws {
        let app = XCUIApplication()
        app.launch()
        let collectionViewsQuery = app.collectionViews

        let cell = XCUIApplication().collectionViews.cells.otherElements.containing(
            .staticText, identifier: "Apam balik").element.waitForExistence(timeout: 10)
        XCTAssertTrue(cell)

        let fetchDessertsLabel = collectionViewsQuery.staticTexts["Fetch Desserts"]
        XCTAssertTrue(fetchDessertsLabel.exists)
    }

    func testSearch() throws {
        let app = XCUIApplication()
        app.launch()

        let cell = XCUIApplication().collectionViews.cells.otherElements.containing(
            .staticText, identifier: "Apam balik").element.waitForExistence(timeout: 10)
        XCTAssertTrue(cell)

        let collectionViewsQuery = app.collectionViews
        let searchTextField = collectionViewsQuery.textFields["Search for desserts"]
        XCTAssertTrue(searchTextField.exists)

        searchTextField.tap()
        searchTextField.typeText("Apam")
        XCUIApplication().collectionViews.cells.otherElements.containing(
            .staticText, identifier: "Apam balik").element.tap()
    }
}
