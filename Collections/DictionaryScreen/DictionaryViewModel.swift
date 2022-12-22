//
//  DictionaryViewModel.swift
//  Collections
//
//  Created by Beavean on 15.12.2022.
//

import Foundation

final class DictionaryViewModel {
    
    //MARK: - Properties
    
    private(set) var arrayWithContacts = [Contact]()
    private(set) var dictionaryWithContacts = [String: String]()
    private(set) lazy var firstContactName = "Name0"
    private(set) lazy var firstContactNumber = "0"
    private(set) lazy var lastContactName = "Name\(Constants.amountOfElementsToCreate - 1)"
    private(set) lazy var lastContactNumber = "\(Constants.amountOfElementsToCreate - 1)"
    private var nonExistingContactNumber = "\(Constants.amountOfElementsToCreate)"
    private var nonExistingContactName = "Name\(Constants.amountOfElementsToCreate)"
    private(set) var searchContactNumber = ""
    private let processingQueue = DispatchQueue(label: "background.Collections", qos: .userInitiated)
    private(set) lazy var hasData: Bool = {
        return !arrayWithContacts.isEmpty && !dictionaryWithContacts.isEmpty
    }()
    
    //MARK: - Modeling Methods
    
    func generateCollections(completion: @escaping() -> Void) {
        processingQueue.async { [self] in
            var array = [Contact]()
            var dictionary = [String: String]()
            for number in 0...Constants.amountOfElementsToCreate - 1 {
                array.append(Contact(name: "Name\(number)", phoneNumber: "\(number)"))
                dictionary["Name\(number)"] = "\(number)"
            }
            arrayWithContacts = array
            dictionaryWithContacts = dictionary
            firstContactNumber = array.first!.phoneNumber
            firstContactName = array.first!.name
            lastContactNumber = array.last!.phoneNumber
            lastContactName = array.last!.name
            nonExistingContactNumber = "\(array.count)"
            completion()
        }
    }
    
    func createTitle(forCellAt indexPath: IndexPath) -> String {
        switch DictionaryOperation.allCases[indexPath.row] {
        case .findFirstContactInArray, .findFirstContactInDictionary:
            return "Find the first contact"
        case .findLastContactInArray, .findLastContactInDictionary:
            return "Find the last contact"
        case .searchForNonExistingElementInArray, .searchForNonExistingElementInDictionary:
            return "Search for a non-existing element"
        }
    }
    
    func performOperation(ofType operationType: DictionaryOperation, completion: @escaping (String) -> Void) {
        processingQueue.async { [self] in
            let startTime = DispatchTime.now()
            switch operationType {
            case .findFirstContactInArray:
                findFirstContactInArray()
            case .findFirstContactInDictionary:
                findFirstContactInDictionary()
            case .findLastContactInArray:
                findLastContactInArray()
            case .findLastContactInDictionary:
                findLastContactInDictionary()
            case .searchForNonExistingElementInArray:
                searchForNonExistingElementInArray()
            case .searchForNonExistingElementInDictionary:
                searchForNonExistingElementInDictionary()
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
    
    private func findFirstContactInArray() {
        guard let firstContactNumber = arrayWithContacts.first?.phoneNumber else { return }
        searchContactNumber = firstContactNumber
    }
    
    private func findFirstContactInDictionary() {
        guard let firstContactNumber = dictionaryWithContacts[firstContactName] else { return }
        searchContactNumber = firstContactNumber
    }
    
    private func findLastContactInArray() {
        guard let lastContactNumber = arrayWithContacts.last?.phoneNumber else { return }
        searchContactNumber = lastContactNumber
    }
    
    private func findLastContactInDictionary() {
        guard let lastContactNumber = dictionaryWithContacts[lastContactName] else { return }
        searchContactNumber = lastContactNumber
    }
    
    private func searchForNonExistingElementInArray() {
        searchContactNumber = nonExistingContactNumber
        _ = arrayWithContacts.first(where: { $0.phoneNumber == nonExistingContactNumber })?.phoneNumber
    }
    
    private func searchForNonExistingElementInDictionary() {
        guard dictionaryWithContacts[nonExistingContactName] == nil else { return }
        searchContactNumber = nonExistingContactNumber
    }
    
    private func createStringWithTimeInterval(operationType: DictionaryOperation, timeInterval: Double) -> String {
        var titlePrefix = ""
        var titleSuffix = ""
        let convertedTimeInterval = "\(String(format: "%.3f", timeInterval)) ms."
        switch operationType {
        case .findFirstContactInArray, .findFirstContactInDictionary:
            titlePrefix = "First"
            titleSuffix = "\nResult number: \(searchContactNumber)"
        case .findLastContactInArray, .findLastContactInDictionary:
            titlePrefix = "Last"
            titleSuffix = "\nResult number: \(searchContactNumber)"
        case .searchForNonExistingElementInArray, .searchForNonExistingElementInDictionary:
            titlePrefix = "Non-existing"
            titleSuffix = "\nNon-existing number: \(searchContactNumber)"
        }
        return titlePrefix + " element search time: " + convertedTimeInterval + titleSuffix
    }
}

