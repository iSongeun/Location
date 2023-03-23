//
//  SearchResultTableViewController.swift
//  Location
//
//  Created by 이송은 on 2023/03/23.
//

import UIKit

class SearchResultTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}

class ResultsCell : UITableViewCell {
    @IBOutlet weak var titleLabel : UILabel!
}
