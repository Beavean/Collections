//
//  ArrayViewModelAsyncTests.swift
//  CollectionsAsyncUnitTests
//
//  Created by Beavean on 23.12.2022.
//

import XCTest
@testable import Collections

final class ArrayViewModelAsyncTests: XCTestCase {

    private var sut: ArrayViewModel!

    override func setUp() {
        super.setUp()
        sut = ArrayViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testCreateIntArray() {
        let expectation = expectation(description: "testCreateIntArray")
           sut.performOperation(ofType: ArrayOperation.createIntArray, completion: { _ in
            self.sut.performOperation(ofType: ArrayOperation.insertElementsAtTheBeginningAtOnce, completion: { _ in
                expectation.fulfill()
            })
        })
        waitForExpectations(timeout: 10.0) { error in
            if error != nil {
                XCTFail()
            } else {
                let arraySize = self.sut.mainArray.count
                let expectedArraySize = Constants.amountOfElementsToCreate + Constants.amountOfElementsToOperate
                XCTAssertEqual(arraySize, expectedArraySize)
            }
        }
    }
    
    func testInsertElementsAtTheBeginningOneByOne() {
        let expectation = expectation(description: "testInsertElementsAtTheBeginningOneByOne")
        sut.performOperation(ofType: ArrayOperation.createIntArray, completion: { _ in
            self.sut.performOperation(ofType: ArrayOperation.insertElementsAtTheBeginningOneByOne, completion: { _ in
                expectation.fulfill()
            })
        })
        waitForExpectations(timeout: 20.0) { error in
            if error != nil {
                XCTFail()
            } else {
                let arraySize = self.sut.mainArray.count
                let expectedArraySize = Constants.amountOfElementsToCreate + Constants.amountOfElementsToOperate
                XCTAssertEqual(arraySize, expectedArraySize)
            }
        }
    }
    
    func testInsertElementsAtTheBeginningAtOnce() {
        let expectation = expectation(description: "testInsertElementsAtTheBeginningAtOnce")
           sut.performOperation(ofType: ArrayOperation.createIntArray, completion: { _ in
            self.sut.performOperation(ofType: ArrayOperation.insertElementsAtTheBeginningAtOnce, completion: { _ in
                expectation.fulfill()
            })
        })
        waitForExpectations(timeout: 10.0) { error in
            if error != nil {
                XCTFail()
            } else {
                let arraySize = self.sut.mainArray.count
                let expectedArraySize = Constants.amountOfElementsToCreate + Constants.amountOfElementsToOperate
                XCTAssertEqual(arraySize, expectedArraySize)
            }
        }
    }
    
    func testInsertElementsInTheMiddleOneByOne() {
        let expectation = expectation(description: "testInsertElementsInTheMiddleOneByOne")
           sut.performOperation(ofType: ArrayOperation.createIntArray, completion: { _ in
            self.sut.performOperation(ofType: ArrayOperation.insertElementsInTheMiddleOneByOne, completion: { _ in
                expectation.fulfill()
            })
        })
        waitForExpectations(timeout: 20.0) { error in
            if error != nil {
                XCTFail()
            } else {
                let arraySize = self.sut.mainArray.count
                let expectedArraySize = Constants.amountOfElementsToCreate + Constants.amountOfElementsToOperate
                XCTAssertEqual(arraySize, expectedArraySize)
            }
        }
    }
    
    func testInsertElementsInTheMiddleAtOnce() {
        let expectation = expectation(description: "testInsertElementsInTheMiddleAtOnce")
           sut.performOperation(ofType: ArrayOperation.createIntArray, completion: { _ in
            self.sut.performOperation(ofType: ArrayOperation.insertElementsInTheMiddleAtOnce, completion: { _ in
                expectation.fulfill()
            })
        })
        waitForExpectations(timeout: 10.0) { error in
            if error != nil {
                XCTFail()
            } else {
                let arraySize = self.sut.mainArray.count
                let expectedArraySize = Constants.amountOfElementsToCreate + Constants.amountOfElementsToOperate
                XCTAssertEqual(arraySize, expectedArraySize)
            }
        }
    }
    
    func testAppendElementsAtTheEndOneByOne() {
        let expectation = expectation(description: "testAppendElementsAtTheEndOneByOne")
           sut.performOperation(ofType: ArrayOperation.createIntArray, completion: { _ in
            self.sut.performOperation(ofType: ArrayOperation.appendElementsAtTheEndOneByOne, completion: { _ in
                expectation.fulfill()
            })
        })
        waitForExpectations(timeout: 10.0) { error in
            if error != nil {
                XCTFail()
            } else {
                let arraySize = self.sut.mainArray.count
                let expectedArraySize = Constants.amountOfElementsToCreate + Constants.amountOfElementsToOperate
                XCTAssertEqual(arraySize, expectedArraySize)
            }
        }
    }
    
    func testAppendElementsAtTheEndAtOnce() {
        let expectation = expectation(description: "testAppendElementsAtTheEndAtOnce")
           sut.performOperation(ofType: ArrayOperation.createIntArray, completion: { _ in
            self.sut.performOperation(ofType: ArrayOperation.appendElementsAtTheEndAtOnce, completion: { _ in
                expectation.fulfill()
            })
        })
        waitForExpectations(timeout: 10.0) { error in
            if error != nil {
                XCTFail()
            } else {
                let arraySize = self.sut.mainArray.count
                let expectedArraySize = Constants.amountOfElementsToCreate + Constants.amountOfElementsToOperate
                XCTAssertEqual(arraySize, expectedArraySize)
            }
        }
    }
    
    func testRemoveElementsAtTheBeginningOneByOne() {
        let expectation = expectation(description: "testRemoveElementsAtTheBeginningOneByOne")
           sut.performOperation(ofType: ArrayOperation.createIntArray, completion: { _ in
            self.sut.performOperation(ofType: ArrayOperation.removeElementsAtTheBeginningOneByOne, completion: { _ in
                expectation.fulfill()
            })
        })
        waitForExpectations(timeout: 20.0) { error in
            if error != nil {
                XCTFail()
            } else {
                let arraySize = self.sut.mainArray.count
                let expectedArraySize = Constants.amountOfElementsToCreate - Constants.amountOfElementsToOperate
                XCTAssertEqual(arraySize, expectedArraySize)
            }
        }
    }
    
    func testRemoveElementsAtTheBeginningAtOnce() {
        let expectation = expectation(description: "testRemoveElementsAtTheBeginningAtOnce")
           sut.performOperation(ofType: ArrayOperation.createIntArray, completion: { _ in
            self.sut.performOperation(ofType: ArrayOperation.removeElementsAtTheBeginningAtOnce, completion: { _ in
                expectation.fulfill()
            })
        })
        waitForExpectations(timeout: 20.0) { error in
            if error != nil {
                XCTFail()
            } else {
                let arraySize = self.sut.mainArray.count
                let expectedArraySize = Constants.amountOfElementsToCreate - Constants.amountOfElementsToOperate
                XCTAssertEqual(arraySize, expectedArraySize)
            }
        }
    }
    
    func testRemoveElementsInTheMiddleOneByOne() {
        let expectation = expectation(description: "testRemoveElementsInTheMiddleOneByOne")
           sut.performOperation(ofType: ArrayOperation.createIntArray, completion: { _ in
            self.sut.performOperation(ofType: ArrayOperation.removeElementsInTheMiddleOneByOne, completion: { _ in
                expectation.fulfill()
            })
        })
        waitForExpectations(timeout: 20.0) { error in
            if error != nil {
                XCTFail()
            } else {
                let arraySize = self.sut.mainArray.count
                let expectedArraySize = Constants.amountOfElementsToCreate - Constants.amountOfElementsToOperate
                XCTAssertEqual(arraySize, expectedArraySize)
            }
        }
    }
    
    func testRemoveElementsInTheMiddleAtOnce() {
        let expectation = expectation(description: "testRemoveElementsInTheMiddleAtOnce")
           sut.performOperation(ofType: ArrayOperation.createIntArray, completion: { _ in
            self.sut.performOperation(ofType: ArrayOperation.removeElementsInTheMiddleAtOnce, completion: { _ in
                expectation.fulfill()
            })
        })
        waitForExpectations(timeout: 20.0) { error in
            if error != nil {
                XCTFail()
            } else {
                let arraySize = self.sut.mainArray.count
                let expectedArraySize = Constants.amountOfElementsToCreate - Constants.amountOfElementsToOperate
                XCTAssertEqual(arraySize, expectedArraySize)
            }
        }
    }
    
    func testRemoveElementsAtTheEndOneByOne() {
        let expectation = expectation(description: "testRemoveElementsAtTheEndOneByOne")
           sut.performOperation(ofType: ArrayOperation.createIntArray, completion: { _ in
            self.sut.performOperation(ofType: ArrayOperation.removeElementsAtTheEndOneByOne, completion: { _ in
                expectation.fulfill()
            })
        })
        waitForExpectations(timeout: 20.0) { error in
            if error != nil {
                XCTFail()
            } else {
                let arraySize = self.sut.mainArray.count
                let expectedArraySize = Constants.amountOfElementsToCreate - Constants.amountOfElementsToOperate
                XCTAssertEqual(arraySize, expectedArraySize)
            }
        }
    }
    
    func testRemoveElementsAtTheEndAtOnce() {
        let expectation = expectation(description: "testRemoveElementsAtTheEndAtOnce")
           sut.performOperation(ofType: ArrayOperation.createIntArray, completion: { _ in
            self.sut.performOperation(ofType: ArrayOperation.removeElementsAtTheEndAtOnce, completion: { _ in
                expectation.fulfill()
            })
        })
        waitForExpectations(timeout: 20.0) { error in
            if error != nil {
                XCTFail()
            } else {
                let arraySize = self.sut.mainArray.count
                let expectedArraySize = Constants.amountOfElementsToCreate - Constants.amountOfElementsToOperate
                XCTAssertEqual(arraySize, expectedArraySize)
            }
        }
    }
}

