//
//  ViewController.swift
//  UltimateMain
//
//  Created by I Wayan Adnyana on 09/04/22.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    var toDoItems: [ToDoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadData()
    }
    
    func loadData(){
        let directoryURL  = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("todos").appendingPathComponent("json")
        
        guard let data = try? Data(contentsOf: documentURL) else {
            return
        }
        let jsonDecoder = JSONDecoder()
        do {
            toDoItems = try jsonDecoder.decode(Array<ToDoItem>.self, from: data)
            tableView.reloadData()
        } catch {
            print("error : Could not save data\(error.localizedDescription)")
        }
    }
    
    func saveData(){
        let directoryURL  = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("todos").appendingPathComponent("json")
        
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(toDoItems)
        do {
            try data?.write(to: documentURL, options: .noFileProtection)
        } catch {
            print("error : Could not save data\(error.localizedDescription)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! UltiTableViewController
            let selectedIndexPatch = tableView.indexPathForSelectedRow!
            destination.toDoItem = toDoItems[selectedIndexPatch.row]
        } else {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }
    @IBAction func unwindFromDetail(segue: UIStoryboardSegue){
        let source = segue.source as! UltiTableViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow{
            toDoItems[selectedIndexPath.row] = source.toDoItem
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: toDoItems.count, section: 0)
            toDoItems.append(source.toDoItem)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
        saveData()
    }
}



extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("just call\(toDoItems.count)")
        return toDoItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = toDoItems[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveData()
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemMove = toDoItems[sourceIndexPath.row]
        toDoItems.remove(at: sourceIndexPath.row)
        toDoItems.insert(itemMove, at: destinationIndexPath.row)
        saveData()
    }
}

