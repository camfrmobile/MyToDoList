//
//  EditToDoListViewController.swift
//  MyToDoList
//
//  Created by Trần Văn Cam on 17/11/2022.
//

import UIKit

class EditToDoListViewController: UIViewController {
    
    @IBOutlet weak var toDoTextView: UITextView!
    @IBOutlet weak var expiredTextField: UITextField!
    @IBOutlet weak var isDoneSwitch: UISwitch!
    @IBOutlet weak var buttonSave: UIButton!
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .inline
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "vi")
        return picker
    } ()
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.locale = Locale(identifier: "vi")
        return formatter
    } ()
    
    var toDoList: ToDoList = ToDoList(todo: "", isDone: false, expired: "")
    var index: Int?
    
    var handleSave: ((ToDoList) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        if index == nil {
            buttonSave.backgroundColor = .green
            buttonSave.titleLabel?.text = "Thêm mới"
        } else {
            buttonSave.backgroundColor = .cyan
            buttonSave.titleLabel?.text = "Cập nhật"
            
            toDoTextView.text = toDoList.todo
            expiredTextField.text = toDoList.expired
            isDoneSwitch.isOn = toDoList.isDone
            
            datePicker.date = formatter.date(from: toDoList.expired) ?? Date()
        }
        toDoTextView.becomeFirstResponder()
        
        datePicker.addTarget(self, action: #selector(handleDateChange), for: .valueChanged)
        
        expiredTextField.inputAccessoryView = datePicker
    }

    @IBAction func actionSaveButton(_ sender: UIButton) {
        toDoList.todo = toDoTextView.text ?? ""
        toDoList.expired = expiredTextField.text ?? ""
        toDoList.isDone = isDoneSwitch.isOn
        
        handleSave?(toDoList)
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func handleDateChange() {
        expiredTextField.text = formatter.string(from: datePicker.date)
        view.endEditing(true)
    }
}
