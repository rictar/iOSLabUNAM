//
//  OrderTableViewController.swift
//  OrderApp
//
//  Created by Ricardo Yepez on 06/09/18.
//  Copyright © 2018 Ricardo Yepez. All rights reserved.
//

import UIKit

protocol AddToOrderDelegate {
    func added(menuItem: MenuItem)
}

class OrderTableViewController: UITableViewController,AddToOrderDelegate {
    
    
    
    var menuItems = [MenuItem]()
    var orderMinutes: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCellItentifier", for: indexPath)
        
        configure(cell: cell, forItemAt: indexPath)

        return cell
    }
    
    func configure(cell: UITableViewCell,forItemAt indexPath:IndexPath){
        let menuItem = menuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = String(format: "$%.2f", menuItem.price)
        MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
            guard let image = image else {return}
            DispatchQueue.main.async {
                if let currentIndexPath = self.tableView.indexPath(for: cell),currentIndexPath != indexPath{
                    return
                }
                cell.imageView?.image = image
                
                let imageView = cell.imageView
                let screenSize: CGRect =
                    cell.bounds
                imageView?.frame = CGRect(x: 10, y: 10, width: 80, height: screenSize.height*0.8)
            }
        }
    }
 
    func added(menuItem: MenuItem) {
        menuItems.append(menuItem)
        let count = menuItems.count
        let indexPath = IndexPath(row: count-1, section: 0 )
        tableView.insertRows(at: [indexPath], with: .automatic)
        updateBadgeNumber()
    }
    
    func updateBadgeNumber() {
        let badgeValue = menuItems.count > 0 ? "\(menuItems.count)" : nil
        navigationController?.tabBarItem.badgeValue = badgeValue
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            menuItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateBadgeNumber()
        }
    }
 
    @IBAction func unwindToOrderList(segue: UIStoryboardSegue) {
        menuItems.removeAll()
        tableView.reloadData()
        updateBadgeNumber()
        
    }
    
    @IBAction func submitTapped(_ sender: Any) {
        let orderTotal = menuItems.reduce(0.0) { (result, menuItem) -> Double in
            return result + menuItem.price
        }
        let formattedOrder = String(format: "$%.2f", orderTotal)
        let alert = UIAlertController(title: "Confirm Order", message: "You are about to submit your order with a total of \(formattedOrder)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Submit", style: .default) { action in
            self.uploadOrder()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func uploadOrder() {
        let menuIds = menuItems.map { $0.id }
        MenuController.shared.submitOrder(menuIds: menuIds) { (minutes) in
            DispatchQueue.main.async {
                if let minutes = minutes {
                    self.orderMinutes = minutes
                    self.performSegue(withIdentifier: "ConfirmationSegue", sender: nil)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ConfirmationSegue" {
            let orderConfirmationViewController = segue.destination as! OrderConfirmationViewController
            orderConfirmationViewController.minutes = orderMinutes
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
