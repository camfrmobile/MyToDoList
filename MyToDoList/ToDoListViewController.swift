//
//  ToDoListViewController.swift
//  MyToDoList
//
//  Created by Trần Văn Cam on 17/11/2022.
//

import UIKit

class ToDoListViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var toDoLists: [ToDoList] = fakeData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //title = "Việc cần làm"
        navigationItem.title = "Việc cần làm"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(actionAddButton))
        
        navigationItem.rightBarButtonItems = [addButton]
    }

    @objc func actionAddButton() {
        let addToDoListVC = EditToDoListViewController()
        //addToDoListVC.title = "Thêm việc cần làm"
        
        addToDoListVC.handleSave = { newToDo in
            self.toDoLists.append(newToDo)
            self.tableView.reloadData()
        }
        
        navigationController?.pushViewController(addToDoListVC, animated: true)
    }
}

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return toDoLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell = UITableViewCell()
        
        let toDo = toDoLists[indexPath.row]
        var title = "\(toDo.imagePath.count > 0 ? "🏞" : "")\(toDo.videoPath.count > 0 ? "🎬" : "")\(toDo.todo)"

        tableCell.textLabel?.text = title
        
        tableCell.detailTextLabel?.text = toDo.expired
        
        if toDo.isDone {
            tableCell.imageView?.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            tableCell.imageView?.image = UIImage(systemName: "poweroff")
            tableCell.imageView?.tintColor = .black
        }
        
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let alertController = UIAlertController(title: toDoLists[indexPath.row].todo, message: "", preferredStyle: .alert)
//        let actionOk = UIAlertAction(title: "OK", style: .cancel)
//        alertController.addAction(actionOk)
        
        let noteVC = NoteViewController()
        noteVC.toDoList = toDoLists[indexPath.row]
        
        navigationController?.pushViewController(noteVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "Xoá") { content, view, closure in
            
            self.toDoLists.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = .red
        let editAction = UIContextualAction(style: .normal, title: "Sửa") { context, view, closure in
            print("edit")
            
            let editToDoListVC = EditToDoListViewController()
            //editToDoListVC.title = "Sửa việc cần làm"
            
            editToDoListVC.toDoList = self.toDoLists[indexPath.row]
            editToDoListVC.index = indexPath.row
            
            editToDoListVC.handleSave = { newToDo in
                self.toDoLists[indexPath.row] = newToDo
                self.tableView.reloadData()
            }
            
            self.navigationController?.pushViewController(editToDoListVC, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let doneAction = UIContextualAction(style: .normal, title: "") { context, view, closure in
            self.toDoLists[indexPath.row].isDone = !self.toDoLists[indexPath.row].isDone
            self.tableView.reloadData()
        }
        if toDoLists[indexPath.row].isDone {
            doneAction.title = "Đánh dấu Chưa làm"
        } else {
            doneAction.title = "Đánh dấu Đã làm"
        }
        return UISwipeActionsConfiguration(actions: [doneAction])
    }
}
