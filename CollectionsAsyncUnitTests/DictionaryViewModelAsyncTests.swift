//
//  DictionaryViewModelAsyncTests.swift
//  CollectionsAsyncUnitTests
//
//  Created by Beavean on 23.12.2022.
//

import Foundation

import XCTest
@testable import Collections

final class DictionaryViewModelAsyncTests: XCTestCase {

    var sut: DictionaryViewModel!

    override func setUp() {
        super.setUp()
        sut = DictionaryViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testGenerateCollections() {
        let expectation = expectation(description: "testGenerateCollections")
        sut.generateCollections {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 20.0) { [self] error in
            if error != nil {
                XCTFail()
            } else {
                let arraySize = sut.dictionaryWithContacts.count
                let dictionarySize = sut.arrayWithContacts.count
                let expectedSize = Constants.amountOfElementsToCreate
                XCTAssertEqual(arraySize, expectedSize)
                XCTAssertEqual(dictionarySize, expectedSize)
            }
        }
    }
    
    func testFindFirstContactInArray() {
        let expectation = expectation(description: "testFindFirstContactInArray")
        sut.generateCollections {
            self.sut.performOperation(ofType: DictionaryOperation.findFirstContactInArray) { _ in
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 20.0) { [self] error in
            if error != nil {
                XCTFail()
            } else {
                let contactNumber = sut.firstContactNumber
                let expectedContactNumber = sut.searchContactNumber
                XCTAssertEqual(contactNumber, expectedContactNumber)
            }
        }
    }
    
    func testFindFirstContactInDictionary() {
        let expectation = expectation(description: "testFindFirstContactInDictionary")
        sut.generateCollections {
            self.sut.performOperation(ofType: DictionaryOperation.findFirstContactInDictionary) { _ in
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 20.0) { [self] error in
            if error != nil {
                XCTFail()
            } else {
                let contactNumber = sut.firstContactNumber
                let expectedContactNumber = sut.searchContactNumber
                XCTAssertEqual(contactNumber, expectedContactNumber)
            }
        }
    }

    func testFindLastContactInArray() {
        let expectation = expectation(description: "testFindLastContactInArray")
        sut.generateCollections {
            self.sut.performOperation(ofType: DictionaryOperation.findLastContactInArray) { _ in
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 20.0) { [self] error in
            if error != nil {
                XCTFail()
            } else {
                let contactNumber = sut.lastContactNumber
                let expectedContactNumber = sut.searchContactNumber
                XCTAssertEqual(contactNumber, expectedContactNumber)
            }
        }
    }

    func testFindLastContactInDictionary() {
        func testFindLastContactInArray() {
            let expectation = expectation(description: "testFindLastContactInDictionary")
            sut.generateCollections {
                self.sut.performOperation(ofType: DictionaryOperation.findFirstContactInDictionary) { _ in
                    expectation.fulfill()
                }
            }
            waitForExpectations(timeout: 20.0) { [self] error in
                if error != nil {
                    XCTFail()
                } else {
                    let contactNumber = sut.lastContactNumber
                    let expectedContactNumber = sut.searchContactNumber
                    XCTAssertEqual(contactNumber, expectedContactNumber)
                }
            }
        }
    }
}
