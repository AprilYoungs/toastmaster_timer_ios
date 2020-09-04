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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    func render() {
        self.title = "Saved list"
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        self.tableView.tableFooterView = UIView()
    }
    
    @IBAction func shareAction(_ sender: Any) {
        
        let textToShare = RecordManager.instance.sharableText()
        let activityController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        
        self.present(activityController, animated: true, completion: nil)
        
    }
    @IBAction func removeAll(_ sender: Any) {
        let alertController = UIAlertController(title: "Are you sure want to remove all", message: nil, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "remove", style: .default, handler: { _ in
            
            RecordManager.instance.removeAll()
            self.tableView.reloadData()
            
        }))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecordManager.instance.numberOfItem + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordItemCellID", for: indexPath) as! RecordItemCell
        
        if indexPath.row == 0 {
            cell.setAsHeader()
        } else if let record = RecordManager.instance.itemAtIndex(indexPath.row - 1) {
            
            cell.configure(recordItem: record)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath.row > 0,
            let record = RecordManager.instance.itemAtIndex(indexPath.row - 1) else
            { return }
        
        let alertController = UIAlertController(title: "update the name", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "New name here"
            textField.text = record.name
        }
        
        alertController.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "update", style: .default, handler: { _ in
            if let newName = alertController.textFields?.first?.text {
                let newRecord = RecordItem(name: newName, totalTime: record.totalTime, usedTime: record.usedTime)
                
                RecordManager.instance.replaceItem(index: indexPath.row-1, with: newRecord)
                self.tableView.reloadData()
            }
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row > 0 {
            return .delete
        } else {
            return .none
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && indexPath.row > 0 {
            
            let alertController = UIAlertController(title: "Are you sure want to delete this item?", message: nil, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "delete", style: .default, handler: { _ in
                
                RecordManager.instance.removeItem(index: indexPath.row-1)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                
            }))
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
}

