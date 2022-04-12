//
//  UltiTableViewController.swift
//  UltimateMain
//
//  Created by I Wayan Adnyana on 09/04/22.
//

import UIKit

class UltiTableViewController: UITableViewController {

    @IBOutlet weak var saveAdd: UIBarButtonItem!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dateAdd: UIDatePicker!
    @IBOutlet weak var noteAdd: UITextView!
    
    @IBOutlet weak var timeToChoice: UILabel!
    
    var toDoItem: ToDoItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if toDoItem == nil {
            toDoItem = ToDoItem(name: "", date: Date(), notes: "")
        }
        nameField.text = toDoItem.name
        dateAdd.date = toDoItem.date
        noteAdd.text = toDoItem.notes
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        toDoItem = ToDoItem(name: nameField.text!, date: dateAdd.date, notes: noteAdd.text)
    }
    
    @IBAction func cancelAdd(_ sender: UIBarButtonItem) {
        let PresentingAdd = presentingViewController is UINavigationController
        if PresentingAdd {
            dismiss(animated: true, completion: nil)
        }else {
            navigationController?.popViewController(animated: true)
        }
    }
}
