//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Ricardo Yepez on 02/09/18.
//  Copyright © 2018 Ricardo Yepez. All rights reserved.
//

import UIKit

class ToDoCell: UITableViewCell {
    
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func completeButtonTapped(){
        delegate?.checkmarkTapped(sender: self)
    }
    var delegate: ToDoCellDelegate?
}

@objc protocol ToDoCellDelegate: class{
    func checkmarkTapped(sender: ToDoCell)
}
