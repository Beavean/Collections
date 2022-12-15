//
//  SetViewController.swift
//  Collections
//
//  Created by Beavean on 13.12.2022.
//

import UIKit

final class SetViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var firstTextField: UITextField!
    @IBOutlet private weak var secondTextField: UITextField!
    @IBOutlet private weak var allMatchingLetterLabel: UILabel!
    @IBOutlet private weak var allNotMatchingCharactersLabel: UILabel!
    @IBOutlet private weak var allUniqueCharactersLabel: UILabel!
    @IBOutlet private weak var allMatchingLetterButton: UIButton!
    @IBOutlet private weak var allNotMatchingCharactersButton: UIButton!
    @IBOutlet private weak var allUniqueCharactersButton: UIButton!
    
    //MARK: - Properties
    
    private let viewModel = SetViewModel()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addKeyboardDismissal()
    }
    
    //MARK: - IBActions
    
    @IBAction func operationButtonPressed(_ sender: UIButton) {
        guard let firstString = firstTextField.text, let secondString = secondTextField.text else { return }
        switch sender {
        case allMatchingLetterButton:
            allMatchingLetterLabel.text = viewModel.getAllMatchingLetters(firstString: firstString, secondString: secondString)
        case allNotMatchingCharactersButton:
            allNotMatchingCharactersLabel.text = viewModel.getAllNotMatchingCharacters(firstString: firstString, secondString: secondString)
        case allUniqueCharactersButton:
            allUniqueCharactersLabel.text = viewModel.getAllUniqueCharacters(firstString: firstString, secondString: secondString)
        default:
            break
        }
    }
    
    //MARK: - Configure
    
    private func configure() {
        firstTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        secondTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    //MARK: - Keyboard dismissal
    
    private func addKeyboardDismissal() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - Selectors
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        switch textField {
        case firstTextField:
            textField.text = viewModel.formatInput(fromString: textField.text)
        case secondTextField:
            textField.text = viewModel.formatInput(fromString: textField.text)
        default:
            break
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
