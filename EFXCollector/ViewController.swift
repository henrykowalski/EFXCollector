//
//  ViewController.swift
//  EFXCollector
//
//  Created by Andrzej Palec on 27/04/2017.
//  Copyright © 2017 Andrzej Palec. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var effects : [Effect] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        do {
        effects = try context.fetch(Effect.fetchRequest())
        tableView.reloadData()
        } catch {
            
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return effects.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let effect = effects[indexPath.row]
        cell.textLabel?.text = effect.title
        cell.imageView?.image = UIImage(data: effect.image as! Data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let effect = effects[indexPath.row]
        performSegue(withIdentifier: "effectSegue", sender: effect)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! EFXViewController
        nextVC.effect = sender as? Effect
    }
    
}

