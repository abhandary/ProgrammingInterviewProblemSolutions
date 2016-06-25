//
//  PlayerDetailsTableViewController.swift
//  Ratings
//
//  Created by Akshay Bhandary on 6/23/16.
//  Copyright © 2016 Akshay Bhandary. All rights reserved.
//

import UIKit

class PlayerDetailsTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var detailLabel: UILabel!
    
    var player : Player?
    var game : String = "Chess" {
        didSet {
            detailLabel.text = game
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = "Chess"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            nameTextField.becomeFirstResponder()
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SavePlayerDetail" {
            player = Player(name: nameTextField.text!, game: game, rating: 1)
        }
        if segue.identifier == "PickGame" {
            if let gamesPickerVC = segue.destinationViewController as? GamePickerTableViewController {
                gamesPickerVC.selectedGame = game
            }
        }
    }
    
    @IBAction func unwindWithSelectedGame(segue: UIStoryboardSegue) {
        
        if let gamePickerVC = segue.sourceViewController as? GamePickerTableViewController {
            game = gamePickerVC.selectedGame!
        }
    }
}
