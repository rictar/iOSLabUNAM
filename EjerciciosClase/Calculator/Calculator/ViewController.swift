//
//  ViewController.swift
//  Calculator
//
//  Created by Ricardo Yepez on 18/08/18.
//  Copyright © 2018 Ricardo Yepez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var acButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = ""
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        if let button = sender.titleLabel {
            resultLabel.text = button.text
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

