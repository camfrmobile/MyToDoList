//
//  EditToDoListViewController.swift
//  MyToDoList
//
//  Created by Trần Văn Cam on 17/11/2022.
//

import UIKit

class EditToDoListViewController: UIViewController {
    
    @IBOutlet weak var toDoTextField: UITextField!
    @IBOutlet weak var expiredTextField: UITextField!
    @IBOutlet weak var isDoneSwitch: UISwitch!
    @IBOutlet weak var buttonSave: UIButton!
    
    var toDoList: ToDoList = ToDoList(todo: "", isDone: false, expired: "")
    var index: Int?
    
    var handleSave: ((ToDoList) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if index == nil {
            buttonSave.backgroundColor = .green
            buttonSave.titleLabel?.text = "Thêm mới"
            
            toDoTextField.becomeFirstResponder()
        } else {
            buttonSave.backgroundColor = .cyan
            buttonSave.titleLabel?.text = "Cập nhật"
            
            toDoTextField.text = toDoList.todo
            expiredTextField.text = toDoList.expired
            isDoneSwitch.isOn = toDoList.isDone
        }
    }

    @IBAction func actionSaveButton(_ sender: UIButton) {
        toDoList.todo = toDoTextField.text ?? ""
        toDoList.expired = expiredTextField.text ?? ""
        toDoList.isDone = isDoneSwitch.isOn
        
        handleSave?(toDoList)
        
        navigationController?.popToRootViewController(animated: true)
    }
    
}
