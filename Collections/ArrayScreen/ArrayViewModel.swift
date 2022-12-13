//
//  ArrayViewModel.swift
//  Collections
//
//  Created by Beavean on 20.11.2022.
//

import Foundation

final class ArrayViewModel {
    
    //MARK: - Properties
    
    var onArrayCreate: (() -> Void)?
    private(set) var readyForOperations = false {
        didSet {
            onArrayCreate?()
        }
    }
    private var mainArray = [Int]()
    private let operationalArray = Array(0...Constants.amountOfElementsToOperate - 1)
    private let processingQueue = DispatchQueue(label: "background.Collections", qos: .userInitiated)
    private lazy var mainCellTitle = "Create Int array with \(Constants.amountOfElementsToCreate) elements"
    
    //MARK: - Modeling Methods
    
    func createTitle(forCellAt indexPath: IndexPath) -> String {
        switch ArrayOperation.allCases[indexPath.row] {
        case .createIntArray:
            return mainCellTitle
        case .insertElementsAtTheBeginningOneByOne :
            return "Insert \(Constants.amountOfElementsToOperate) elements at the beginning one-by-one"
        case .insertElementsAtTheBeginningAtOnce:
            return "Insert \(Constants.amountOfElementsToOperate) elements at the beginning at once"
        case .insertElementsInTheMiddleOneByOne:
            return "Insert \(Constants.amountOfElementsToOperate) elements in the middle one-by-one"
        case .insertElementsInTheMiddleAtOnce:
            return "Insert \(Constants.amountOfElementsToOperate) elements in the middle at once"
        case .appendElementsAtTheEndOneByOne:
            return "Append \(Constants.amountOfElementsToOperate) elements to the end one-by-one"
        case .appendElementsAtTheEndAtOnce:
            return "Append \(Constants.amountOfElementsToOperate) elements to the end at once"
        case .removeElementsAtTheBeginningOneByOne:
            return "Remove \(Constants.amountOfElementsToOperate) elements at the beginning one-by-one"
        case .removeElementsAtTheBeginningAtOnce:
            return "Remove \(Constants.amountOfElementsToOperate) elements at the beginning at once"
        case .removeElementsInTheMiddleOneByOne:
            return "Remove \(Constants.amountOfElementsToOperate) elements in the middle one-by-one"
        case .removeElementsInTheMiddleAtOnce:
            return "Remove \(Constants.amountOfElementsToOperate) elements in the middle at once"
        case .removeElementsAtTheEndOneByOne:
            return "Remove \(Constants.amountOfElementsToOperate) elements at the end one-by-one"
        case .removeElementsAtTheEndAtOnce:
            return "Remove \(Constants.amountOfElementsToOperate) elements at the end at once"
        }
    }
    
    func performOperation(ofType operationType: ArrayOperation, completion: @escaping (String) -> Void) {
        processingQueue.async { [self] in
            let startTime = DispatchTime.now()
            switch operationType {
            case .createIntArray:
                createIntArray()
            case .insertElementsAtTheBeginningOneByOne:
                insertElementsAtTheBeginningOneByOne()
            case .insertElementsAtTheBeginningAtOnce:
                insertElementsAtTheBeginningAtOnce()
            case .insertElementsInTheMiddleOneByOne:
                insertElementsInTheMiddleOneByOne()
            case .insertElementsInTheMiddleAtOnce:
                insertElementsInTheMiddleAtOnce()
            case .appendElementsAtTheEndOneByOne:
                appendElementsAtTheEndOneByOne()
            case .appendElementsAtTheEndAtOnce:
                appendElementsAtTheEndAtOnce()
            case .removeElementsAtTheBeginningOneByOne:
                removeElementsAtTheBeginningOneByOne()
            case .removeElementsAtTheBeginningAtOnce:
                removeElementsAtTheBeginningAtOnce()
            case .removeElementsInTheMiddleOneByOne:
                removeElementsInTheMiddleOneByOne()
            case .removeElementsInTheMiddleAtOnce:
                removeElementsInTheMiddleAtOnce()
            case .removeElementsAtTheEndOneByOne:
                removeElementsAtTheEndOneByOne()
            case .removeElementsAtTheEndAtOnce:
                removeElementsAtTheEndAtOnce()
            }
            let endTime = DispatchTime.now()
            let nanoseconds = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
            let timeInterval = Double(nanoseconds) / 1_000_000_000
            DispatchQueue.main.async {
                completion(self.createStringWithTimeInterval(operationType: operationType, timeInterval: timeInterval))
            }
        }
    }
    
    //MARK: - Helpers
    
    private func createIntArray() {
        var array = [Int]()
        for int in 0..<Constants.amountOfElementsToCreate {
            array.append(int)
        }
        mainArray = array
        readyForOperations = true
    }
    
    private func insertElementsAtTheBeginningOneByOne() {
        for int in 0..<Constants.amountOfElementsToOperate {
            mainArray.insert(int, at: 0)
        }
    }
    
    private func insertElementsAtTheBeginningAtOnce() {
        mainArray.insert(contentsOf: operationalArray, at: 0)
    }
    
    private func insertElementsInTheMiddleOneByOne() {
        for int in 0..<Constants.amountOfElementsToOperate {
            mainArray.insert(int, at: mainArray.count / 2)
        }
    }
    
    private func insertElementsInTheMiddleAtOnce() {
        mainArray.insert(contentsOf: operationalArray, at: mainArray.count / 2)
    }
    
    private func appendElementsAtTheEndOneByOne() {
        for int in 0..<Constants.amountOfElementsToOperate {
            mainArray.append(int)
        }
    }
    
    private func appendElementsAtTheEndAtOnce() {
        mainArray.append(contentsOf: operationalArray)
    }
    
    private func removeElementsAtTheBeginningOneByOne() {
        for _ in 0..<Constants.amountOfElementsToOperate {
            mainArray.removeFirst()
        }
    }
    
    private func removeElementsAtTheBeginningAtOnce() {
        mainArray.removeFirst(Constants.amountOfElementsToOperate)
    }
    
    private func removeElementsInTheMiddleOneByOne() {
        for _ in 0..<Constants.amountOfElementsToOperate {
            mainArray.remove(at: mainArray.count / 2)
        }
    }
    
    private func removeElementsInTheMiddleAtOnce() {
        let range = ((mainArray.count / 2) - (Constants.amountOfElementsToOperate / 2))..<((mainArray.count / 2) + (Constants.amountOfElementsToOperate / 2))
        mainArray.removeSubrange(range)
    }
    
    private func removeElementsAtTheEndOneByOne() {
        for _ in 0..<Constants.amountOfElementsToOperate {
            mainArray.removeLast()
        }
    }
    
    private func removeElementsAtTheEndAtOnce() {
        mainArray.removeLast(Constants.amountOfElementsToOperate)
    }
    
    private func createStringWithTimeInterval(operationType: ArrayOperation, timeInterval: Double) -> String {
        var titlePrefix = ""
        let convertedTimeInterval = "\(String(format: "%.3f", timeInterval)) ms."
        switch operationType {
        case .createIntArray:
            titlePrefix = "Array creation"
            mainCellTitle = titlePrefix + " time: " + convertedTimeInterval
        case .insertElementsAtTheBeginningOneByOne:
            fallthrough
        case .insertElementsAtTheBeginningAtOnce:
            fallthrough
        case .insertElementsInTheMiddleOneByOne:
            fallthrough
        case .insertElementsInTheMiddleAtOnce:
            titlePrefix = "Insertion"
        case .appendElementsAtTheEndOneByOne:
            fallthrough
        case .appendElementsAtTheEndAtOnce:
            titlePrefix = "Appending"
        case .removeElementsAtTheBeginningOneByOne:
            fallthrough
        case .removeElementsAtTheBeginningAtOnce:
            fallthrough
        case .removeElementsInTheMiddleOneByOne:
            fallthrough
        case .removeElementsInTheMiddleAtOnce:
            fallthrough
        case .removeElementsAtTheEndOneByOne:
            fallthrough
        case .removeElementsAtTheEndAtOnce:
            titlePrefix = "Removing"
        }
        return titlePrefix + " time: " + convertedTimeInterval
    }
}
