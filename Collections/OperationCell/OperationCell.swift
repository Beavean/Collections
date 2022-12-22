//
//  ArrayOperationCell.swift
//  Collections
//
//  Created by Beavean on 18.11.2022.
//

import UIKit

final class OperationCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var operationActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var operationLabel: UILabel!
    
    //MARK: - Properties
    
    private(set) var hasEndedOperation = false
    
    //MARK: - Configuration
    
    func configure(title: String, hasEndedOperation: Bool) {
        self.hasEndedOperation = hasEndedOperation
        operationLabel.isHidden = false
        operationLabel.adjustsFontSizeToFitWidth = true
        operationActivityIndicator.stopAnimating()
        layer.borderWidth = 1
        operationLabel.textColor = hasEndedOperation ? .black : .systemBlue
        backgroundColor = hasEndedOperation ? .systemGray5 : .systemGray3
        operationLabel.text = title
    }
    
    //MARK: - Helpers
    
    func startOperation() {
        operationLabel.isHidden = true
        operationActivityIndicator.startAnimating()
    }
}
