//
//  SecondViewController.swift
//  iTunesTable
//
//  Created by Ricardo Yepez on 01/09/18.
//  Copyright © 2018 Ricardo Yepez. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var etiqueta: UILabel!
    
    @IBOutlet weak var imageUrl: UIImageView!
    var fromFirstView: String = ""
    
    var urlFromFirstView: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        etiqueta.text = fromFirstView
        
        fetchImage(urlFromFirstView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchImage(_ imageUrl:String){
        
        let url = URL(string: imageUrl)!
        
        print(imageUrl)
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {
            (data, response,error) in
            if let dataImage = try? Data(contentsOf: url) {
                self.imageUrl.image = UIImage(data: dataImage)
            }
            
        })
        task.resume()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
