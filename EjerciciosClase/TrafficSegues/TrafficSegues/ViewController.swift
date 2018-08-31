//
//  ViewController.swift
//  TrafficSegues
//
//  Created by Ricardo Yepez on 24/08/18.
//  Copyright © 2018 Ricardo Yepez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var segueSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        segue.destination.navigationItem.title = textField.text
//    }
    @IBAction func yellowButton(_ sender: UIButton) {
        if segueSwitch.isOn{
            performSegue(withIdentifier: "yellow", sender: nil)
        }
        
    }
    
    @IBAction func YellowButton(_ sender: UIButton) {
        if segueSwitch.isOn{
            performSegue(withIdentifier: "green", sender: nil)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToRed(unwindSegue:UIStoryboardSegue){
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    } 


}

