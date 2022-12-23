//
//  DictionaryViewUITests.swift
//  CollectionsUITests
//
//  Created by Beavean on 23.12.2022.
//

import XCTest

final class DictionaryViewUITests: XCTestCase {
    
    private var app: XCUIApplication!
    private lazy var dictionaryCollectionsCell = app.cells.staticTexts["Dictionary"]
    private lazy var dictionaryCollectionView = app.collectionViews["DictionaryCollectionView"]
    private lazy var arrayLabel = app.staticTexts["ArrayLabel"]
    private lazy var dictionaryLabel = app.staticTexts["DictionaryLabel"]
    private lazy var dictionaryViewElements = [app.collectionViews.staticTexts["Find the first contact"],
                                               app.collectionViews.staticTexts["Find the last contact"],
                                               app.collectionViews.staticTexts["Search for a non-existing element"]]
    
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
        dictionaryCollectionsCell.tap()
        sleep(20)
        XCTAssertTrue(arrayLabel.exists)
        XCTAssertTrue(dictionaryLabel.exists)
        dictionaryViewElements.forEach { XCTAssertTrue($0.exists) }
        for index in 0...5 {
            XCTAssert(app.cells.element(boundBy: index).exists)
        }
    }
    
    func testCellTitleChangesOnSelection() {
        dictionaryCollectionsCell.tap()
        sleep(20)
        for index in 0...5 {
            dictionaryCollectionView.cells.element(boundBy: index).tap()
        }
        dictionaryViewElements.forEach { XCTAssertFalse($0.exists) }
    }
}

