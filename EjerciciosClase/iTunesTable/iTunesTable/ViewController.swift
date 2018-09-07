//
//  ViewController.swift
//  iTunesTable
//
//  Created by Ricardo Yepez on 01/09/18.
//  Copyright © 2018 Ricardo Yepez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var tablita: UITableView!
    var tracks: [Tracks] = []
    let baseUrl = URL(string: "https://itunes.apple.com/search?")!

    override func viewDidLoad() {
        progressView.isHidden = false
        fetchData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        cell.textLabel?.text = tracks[indexPath.row].trackName
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tracks.remove(at: indexPath.row)
            tablita.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            self.tracks.remove(at: indexPath.row)
            self.tablita.reloadData()
        }
        
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
            let text = "Listening \(self.tracks[indexPath.row].trackName)"
            let activityController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
            self.present(activityController,animated: true)
            
        }
        
        shareAction.backgroundColor = UIColor.orange
        let swipeConfiguration  = UISwipeActionsConfiguration(actions: [shareAction,deleteAction])
        return swipeConfiguration
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecond" {
            let indexPath = tablita.indexPathForSelectedRow?.row
            let destination = segue.destination as! SecondViewController
            destination.fromFirstView = tracks[indexPath!].trackName
            destination.urlFromFirstView = tracks[indexPath!].artworkUrl100
            
            
        }
    }
    
    func fetchData(){
        let query : [String:String] = [
            "term":"mecano",
            "limit": "50"
        ]
        
        let url = baseUrl.withQueries(query)
        
        let task = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response,error) in
            if let data = data,  let trackDictionary = try? JSONDecoder().decode(Results.self,from: data) {
                
                var temp:[Tracks] = []
                
                
                trackDictionary.results.forEach({track in
                    temp.append(track)
                })
                
                print(temp)
                self.tracks =  temp
                self.tablita.reloadData()
                
                self.progressView.isHidden = true
            }
            
        })
        task.resume()
        
    }
    
    


}

extension URL{
    func withQueries(_ queries:[String:String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap{ URLQueryItem(name: $0.0, value:$0.1)}
        return components?.url
    }
}

