//
//  DictionaryViewController.swift
//  Collections
//
//  Created by Beavean on 15.12.2022.
//

import UIKit

final class DictionaryViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var operationsCollectionView: UICollectionView!
    @IBOutlet private weak var operationsActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var operationsView: UIView!
    
    //MARK: - Properties
    
    private let viewModel = DictionaryViewModel()
    private let sectionInset: UIEdgeInsets = .zero
    private let spacingBetweenCells: CGFloat = 0
    private let interitemSpacing: CGFloat = 0
    private lazy var cellsAmount = DictionaryOperation.allCases.count
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        operationsCollectionView.register(UINib(nibName: Constants.operationCellReuseID, bundle: nil), forCellWithReuseIdentifier: Constants.operationCellReuseID)
        generateCollections()
    }
    
    private func generateCollections() {
        guard !viewModel.hasData else { return }
        operationsView.isHidden = true
        operationsActivityIndicator.startAnimating()
        viewModel.generateCollections {
            DispatchQueue.main.async { [self] in
                operationsView.isHidden = false
                operationsActivityIndicator.stopAnimating()
            }
        }
    }
}

extension DictionaryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellsAmount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.operationCellReuseID, for: indexPath) as? OperationCell else { return UICollectionViewCell() }
        cell.configure(title: viewModel.createTitle(forCellAt: indexPath), hasEndedOperation: false)
        return cell
    }
}

extension DictionaryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 2
        let numberOfRows = CGFloat(cellsAmount / 2)
        let width = collectionView.safeAreaLayoutGuide.layoutFrame.size.width
        let height = collectionView.safeAreaLayoutGuide.layoutFrame.size.height / 2
        let itemWidth = floor(width / numberOfItemsPerRow)
        let ItemHeight = height / numberOfRows
        return CGSize(width: itemWidth, height: ItemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        spacingBetweenCells
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        interitemSpacing
    }
}

extension DictionaryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? OperationCell,
              !cell.hasEndedOperation
        else { return }
        cell.startOperation()
        self.viewModel.performOperation(ofType: DictionaryOperation.allCases[indexPath.row]) { cellTitle in
            cell.configure(title: cellTitle, hasEndedOperation: true)
        }
    }
}

