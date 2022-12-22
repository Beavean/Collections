//
//  Constants.swift
//  Collections
//
//  Created by Beavean on 17.11.2022.
//

import Foundation

struct Constants {
    
    static let arrayViewSegueIdentifier = "ArrayView"
    static let setViewSegueIdentifier = "SetView"
    
    static let dictionaryStoryboardName = "Dictionary"
    static let dictionaryViewControllerIdentifier = "DictionaryViewController"
    
    static let amountOfElementsToCreate = 10_000_000
    static let amountOfElementsToOperate = 1000
    
    static let operationCellReuseID = String(describing: OperationCell.self)
}
