//
//  ArrayViewController.swift
//  Collections
//
//  Created by Beavean on 18.11.2022.
//

import UIKit

final class ArrayViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var operationsCollectionView: UICollectionView!
    
    //MARK: - Properties
    
    private let viewModel = ArrayViewModel()
    private let sectionInset: UIEdgeInsets = .zero
    private let spacingBetweenCells: CGFloat = 0
    private let interitemSpacing: CGFloat = 0
    private lazy var cellsAmount = ArrayOperation.allCases.count
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupArrayFillCallback()
        operationsCollectionView.register(UINib(nibName: Constants.operationCellReuseID, bundle: nil), forCellWithReuseIdentifier: Constants.operationCellReuseID)
        operationsCollectionView.accessibilityIdentifier = "ArrayCollectionView"
    }
    
    private func setupArrayFillCallback() {
        viewModel.onArrayCreate = {
            DispatchQueue.main.async {
                self.operationsCollectionView.reloadData()
            }
        }
    }
}

extension ArrayViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.readyForOperations ? cellsAmount : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.operationCellReuseID, for: indexPath) as? OperationCell else { return UICollectionViewCell() }
        cell.configure(title: viewModel.createTitle(forCellAt: indexPath), hasEndedOperation: indexPath.row == 0 ? viewModel.readyForOperations : false)
        return cell
    }
}

extension ArrayViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = indexPath.item == 0 ? 1 : 2
        let numberOfRows = CGFloat(cellsAmount % 2 == 1 ? (cellsAmount + 1) / 2 : cellsAmount / 2)
        let width = collectionView.safeAreaLayoutGuide.layoutFrame.size.width
        let height = collectionView.safeAreaLayoutGuide.layoutFrame.size.height
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

extension ArrayViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? OperationCell,
              !cell.hasEndedOperation
        else { return }
        cell.startOperation()
        self.viewModel.performOperation(ofType: ArrayOperation.allCases[indexPath.row]) { cellTitle in
            cell.configure(title: cellTitle, hasEndedOperation: true)
        }
    }
}
