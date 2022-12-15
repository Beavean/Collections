//
//  CollectionsViewController.swift
//  Collections
//
//  Created by Beavean on 17.11.2022.
//

import UIKit

final class CollectionsViewController: UITableViewController {
    
    //MARK: - Lifecycle
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case Constants.arrayViewSegueIdentifier:
            guard let vc = segue.destination as? ArrayViewController else { return }
            vc.navigationItem.title = "Array: \(Int.random(in: 0...999))"
        case Constants.setViewSegueIdentifier:
            guard let vc = segue.destination as? SetViewController else { return }
            vc.navigationItem.largeTitleDisplayMode = .never
            vc.navigationItem.title = "Set: \(Int.random(in: 0...999))"
        default:
            break
        }
    }
    
    //MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            performSegue(withIdentifier: Constants.setViewSegueIdentifier, sender: nil)
        case 2:
            fallthrough
        default:
            break
        }
    }
    
    //MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
}
