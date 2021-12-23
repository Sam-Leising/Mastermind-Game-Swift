//
//  HistoryViewController.swift
//  MastermindGame
//
//  Created by Shen Licheng on 21/11/2021.
//

import UIKit
import CoreData

class HistoryViewController: UITableViewController {
    
    
    @IBOutlet weak var titleView: UIView!
    var game_historys : [Game_History]?;
    var managedObjectContext : NSManagedObjectContext?{
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            return appDelegate.persistentContainer.viewContext
        }
        return nil;
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.searchAndReloadTable(query: "")
    }
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let game_history = self.game_historys {
            return game_history.count
        }
        return 0
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let game_history = self.game_historys?[indexPath.row] {
            cell.textLabel?.text = "\(game_history.user_name!)"
            cell.detailTextLabel?.text = "\(game_history.num_of_time!)"
        }
        return cell;
    }


    
    func searchAndReloadTable(query:String){
        if let managedObjectContext = self.managedObjectContext {
            let fetchRequest = NSFetchRequest<Game_History>(entityName: "Game_History");
            if query.count > 0 {
                let predicate = NSPredicate(format: "name contains[cd] %@", query)
                fetchRequest.predicate = predicate
            }
            do{
                let theDevices = try managedObjectContext.fetch(fetchRequest)
                self.game_historys = theDevices
                self.tableView.reloadData()
            } catch {
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle:UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let game_history  = self.game_historys?.remove(at: indexPath.row) {
                managedObjectContext?.delete(game_history)
                try? self.managedObjectContext?.save()
            }
            self.tableView.deleteRows(at: [indexPath], with: .fade);
        }
    }


}
