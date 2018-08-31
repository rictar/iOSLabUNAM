//
//  ViewController.swift
//  LoginScreen
//
//  Created by Ricardo Yepez on 24/08/18.
//  Copyright © 2018 Ricardo Yepez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func login(_ sender: UIButton) {
        
        if userField.text == "Ricardo" &&
            passwordField.text == "123456a"{
            performSegue(withIdentifier: "successLogin", sender: userField)
        }else{
            performSegue(withIdentifier: "failLogin", sender: userField)
        }
        
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            segue.destination.navigationItem.title = (sender as! UITextField).text
        }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToLogin(unwindSegue:UIStoryboardSegue){
        
    }


}

