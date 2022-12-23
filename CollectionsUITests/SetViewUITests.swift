//
//  SetViewUITests.swift
//  CollectionsUITests
//
//  Created by Beavean on 23.12.2022.
//

import XCTest

final class SetViewUITests: XCTestCase {
    
    private var app: XCUIApplication!
    private lazy var setCollectionsCell = app.cells.staticTexts["Set"]
    private lazy var allMatchingLettersButton = app.buttons["AllMatchingLettersButton"]
    private lazy var allNotMatchingCharactersButton = app.buttons["AllNotMatchingCharactersButton"]
    private lazy var allUniqueCharactersButton = app.buttons["AllUniqueCharactersButton"]
    private lazy var allMatchingLettersLabel = app.staticTexts["AllMatchingLettersLabel"]
    private lazy var allNotMatchingCharactersLabel = app.staticTexts["AllNotMatchingCharactersLabel"]
    private lazy var allUniqueCharactersLabel = app.staticTexts["AllUniqueCharactersLabel"]
    private lazy var firstInputTextField = app.textFields["FirstInputTextField"]
    private lazy var secondInputTextField = app.textFields["SecondInputTextField"]
    
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
    
    func testUIElementsExist() {
        setCollectionsCell.tap()
        XCTAssertTrue(allMatchingLettersButton.exists)
        XCTAssertTrue(allNotMatchingCharactersButton.exists)
        XCTAssertTrue(allUniqueCharactersButton.exists)
        XCTAssertTrue(allMatchingLettersLabel.exists)
        XCTAssertTrue(allNotMatchingCharactersLabel.exists)
        XCTAssertTrue(allUniqueCharactersLabel.exists)
        XCTAssertTrue(firstInputTextField.exists)
        XCTAssertTrue(secondInputTextField.exists)
    }
    
    func testTextFieldsInputFilter() {
        setCollectionsCell.tap()
        firstInputTextField.tap()
        firstInputTextField.typeText("_-qwerty12345QWERTY!@#$%")
        var expectedResult = "qwertyQWERTY"
        XCTAssertEqual(firstInputTextField.value as? String, expectedResult)
        secondInputTextField.tap()
        secondInputTextField.typeText("_-qwerty12345QWERTY!@#$%")
        expectedResult = "qwertyQWERTY"
        XCTAssertEqual(secondInputTextField.value as? String, expectedResult)
    }
    
    func testGetAllMatchingCharacters() {
        setCollectionsCell.tap()
        firstInputTextField.tap()
        firstInputTextField.typeText("_-thisIsTheFirstInput!@#$%")
        secondInputTextField.tap()
        secondInputTextField.typeText("andThatIsTheSecondOne")
        allMatchingLettersButton.tap()
        let expectedOutput = "thsIsThestInt"
        XCTAssertEqual(allMatchingLettersLabel.label, expectedOutput)
    }
    
    func testGetAllNotMatchingCharacters() {
        setCollectionsCell.tap()
        firstInputTextField.tap()
        firstInputTextField.typeText("_-thisIsTheFirstInput!@#$%")
        secondInputTextField.tap()
        secondInputTextField.typeText("andThatIsTheSecondOne")
        allNotMatchingCharactersButton.tap()
        let expectedOutput = "iFirpuadaScodO"
        XCTAssertEqual(allNotMatchingCharactersLabel.label, expectedOutput)
    }
    
    func testGetAllUniqueCharacters() {
        setCollectionsCell.tap()
        firstInputTextField.tap()
        firstInputTextField.typeText("_-thisIsTheFirstInput!@#$%")
        secondInputTextField.tap()
        secondInputTextField.typeText("andThatIsTheSecondOne")
        allUniqueCharactersButton.tap()
        let expectedOutput = "iFirpu"
        XCTAssertEqual(allUniqueCharactersLabel.label, expectedOutput)
    }
}
