//
//  ListViewController.swift
//  ToastmasterTimer
//
//  Created by April Yang on 2020/9/3.
//  Copyright © 2020 April Yang. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        render()
    }
    
    func render() {
        self.title = "Saved list"
    }
    
    @IBAction func shareAction(_ sender: Any) {
        print("shareAction")
    }
}
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

