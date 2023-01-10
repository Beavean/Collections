//
//  CollectionsViewUITests.swift
//  CollectionsUITests
//
//  Created by Beavean on 23.12.2022.
//

import XCTest

final class CollectionsViewUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    private lazy var arrayCell = app.cells.staticTexts["Array"]
    private lazy var setCell = app.cells.staticTexts["Set"]
    private lazy var dictionaryCell = app.cells.staticTexts["Dictionary"]

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
    
    func testCollectionsTableRowsExist() {
        XCTAssertTrue(arrayCell.exists)
        XCTAssertTrue(setCell.exists)
        XCTAssertTrue(dictionaryCell.exists)
    }
}

