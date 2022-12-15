//
//  SetViewModel.swift
//  Collections
//
//  Created by Beavean on 13.12.2022.
//

import Foundation

final class SetViewModel {
    
    private let formatRegexRange = "[a-zA-Z]"
    
    func formatInput(fromString string: String?) -> String? {
        guard let string else { return nil }
        var resultString = String()
        for character in string {
            let characterAsString = String(character)
            resultString += characterAsString.range(of: formatRegexRange, options: .regularExpression) != nil ? characterAsString : String()
        }
        return resultString
    }
    
    func getAllMatchingLetters(firstString: String, secondString: String) -> String {
        var result = String()
        let firstSet = Set(firstString)
        let secondSet = Set(secondString)
        let matchingElements = firstSet.intersection(secondSet)
        for character in firstString where matchingElements.contains(character) {
            result.append(character)
        }
        return result
    }
    
    func getAllNotMatchingCharacters(firstString: String, secondString: String) -> String {
        var result = String()
        let firstSet = Set(firstString)
        let secondSet = Set(secondString)
        let difference = firstSet.symmetricDifference(secondSet)
        for character in firstString where difference.contains(character) {
            result.append(character)
        }
        for character in secondString where difference.contains(character) {
            result.append(character)
        }
        return result
    }
    
    func getAllUniqueCharacters(firstString: String, secondString: String) -> String {
        var result = String()
        let firstSet = Set(firstString)
        let secondSet = Set(secondString)
        let uniqueCharacters = firstSet.subtracting(secondSet)
        for character in firstString where uniqueCharacters.contains(character) {
            result.append(character)
        }
        return result
    }
}
