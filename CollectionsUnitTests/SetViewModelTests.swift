//
//  SetViewModelTests.swift
//  CollectionsUnitTests
//
//  Created by Beavean on 23.12.2022.
//

import XCTest
@testable import Collections

final class SetViewModelTests: XCTestCase {
    
    private var sut: SetViewModel!

    override func setUp() {
        super.setUp()
        sut = SetViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testFormatInput() {
        let input = "_-qwerty12345QWERTY!@#$%"
        let output = "qwertyQWERTY"
        XCTAssertEqual(sut.formatInput(fromString: input), output)
    }
    
    func testGetAllMatchingCharacters() {
        let firstString = "thisIsTheFirstInput"
        let secondString = "andThatIsTheSecondOne"
        let output = "thsIsThestInt"
        XCTAssertEqual(sut.getAllMatchingLetters(firstString: firstString, secondString: secondString), output)
    }
    
    func testGetAllNotMatchingCharacters() {
        let firstString = "thisIsTheFirstInput"
        let secondString = "andThatIsTheSecondOne"
        let output = "iFirpuadaScodO"
        XCTAssertEqual(sut.getAllNotMatchingCharacters(firstString: firstString, secondString: secondString), output)
    }
    
    func testGetAllUniqueCharacters() {
        let firstString = "thisIsTheFirstInput"
        let secondString = "andThatIsTheSecondOne"
        let output = "iFirpu"
        XCTAssertEqual(sut.getAllUniqueCharacters(firstString: firstString, secondString: secondString), output)
    }
}
