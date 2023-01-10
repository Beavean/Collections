//
//  ArrayViewUITests.swift
//  CollectionsUITests
//
//  Created by Beavean on 23.12.2022.
//

import XCTest

final class ArrayViewUITests: XCTestCase {
    
    private var app: XCUIApplication!
    private lazy var arrayCollectionsCell = app.cells.staticTexts["Array"]
    private lazy var arrayCreationCell = app.staticTexts["Create Int array with 10000000 elements"]
    private lazy var arrayCollectionView = app.collectionViews["ArrayCollectionView"]
    private lazy var arrayOperationCells = [app.collectionViews.staticTexts["Insert 1000 elements at the beginning one-by-one"],
                                            app.collectionViews.staticTexts["Insert 1000 elements at the beginning at once"],
                                            app.collectionViews.staticTexts["Insert 1000 elements in the middle one-by-one"],
                                            app.collectionViews.staticTexts["Insert 1000 elements in the middle at once"],
                                            app.collectionViews.staticTexts["Append 1000 elements to the end one-by-one"],
                                            app.collectionViews.staticTexts["Append 1000 elements to the end at once"],
                                            app.collectionViews.staticTexts["Remove 1000 elements at the beginning one-by-one"],
                                            app.collectionViews.staticTexts["Remove 1000 elements at the beginning at once"],
                                            app.collectionViews.staticTexts["Remove 1000 elements in the middle one-by-one"],
                                            app.collectionViews.staticTexts["Remove 1000 elements in the middle at once"],
                                            app.collectionViews.staticTexts["Remove 1000 elements at the end one-by-one"],
                                            app.collectionViews.staticTexts["Remove 1000 elements at the end at once"]]
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func testUIExists() {
        arrayCollectionsCell.tap()
        XCTAssertTrue(arrayCollectionView.exists)
        XCTAssertTrue(arrayCreationCell.exists)
    }
    
    func testOperationCellsAppearance() {
        arrayCollectionsCell.tap()
        XCTAssertEqual(arrayCollectionView.cells.count, 1)
        arrayCreationCell.tap()
        sleep(10)
        arrayOperationCells.forEach { XCTAssertTrue($0.exists) }
        XCTAssertEqual(arrayCollectionView.cells.count, 13)
    }
}

