//
//  ViewController.swift
//  TableView
//
//  Created by Ricardo Yepez on 25/08/18.
//  Copyright © 2018 Ricardo Yepez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate{
    var nombres = ["Luis","Pedro","Juan","Manuel","Luis","Pedro","Juan","Manuel","Luis","Pedro","Juan","Manuel","Luis","Pedro","Juan","Manuel","Luis","Pedro","Juan","Manuel","Luis","Pedro","Juan","Manuel","Luis","Pedro","Juan","Manuel","Luis","Pedro","Juan","Manuel"]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nombres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = nombres[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        
        let alertController = UIAlertController(title: "Alumnos", message: "Hola como estas", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

