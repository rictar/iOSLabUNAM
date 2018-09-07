//
//  ToDoTableTableViewController.swift
//  ToDoList
//
//  Created by Ricardo Yepez on 31/08/18.
//  Copyright © 2018 Ricardo Yepez. All rights reserved.
//

import UIKit

class ToDoTableTableViewController: UITableViewController,ToDoCellDelegate {
    
    var toDos = [ToDo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedToDos = ToDo.loadToDos() {
            toDos = savedToDos
        } else {
            toDos = ToDo.loadSampleToDos()
        }
        navigationItem.leftBarButtonItem = editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as!ToDoTableViewController
        
        if let toDo = sourceViewController.toDo {
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                toDos[selectedIndexPath.row] = toDo
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }else{
                let newIndexPath = IndexPath(row: toDos.count,
                                            section: 0)
                toDos.append(toDo)
                tableView.insertRows(at: [newIndexPath],
                                 with: .automatic)
            }
        }
        
        ToDo.saveToDos(toDos)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell =
            tableView.dequeueReusableCell(withIdentifier:
                "ToDoCellIdentifier") as? ToDoCell else {
                    fatalError("Could not dequeue a cell")
        }
        
        let toDo = toDos[indexPath.row]
        
        cell.titleLabel?.text = toDo.title
        cell.isCompleteButton.isSelected = toDo.isComplete
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            ToDo.saveToDos(toDos)
        }
    }
    
    func checkmarkTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender){
            var toDo = toDos[indexPath.row]
            toDo.isComplete = !toDo.isComplete
            toDos[indexPath.row] = toDo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(toDos)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
        let todoViewController = segue.destination
            as! ToDoTableViewController
        let indexPath = tableView.indexPathForSelectedRow!
        let selectedTodo = toDos[indexPath.row]
        todoViewController.toDo = selectedTodo
    }
    }

}
