//
//  ListViewController.swift
//  Memory
//
//  Created by Tyoma Zagoskin on 15/04/2019.
//  Copyright © 2019 Тёма Загоскин. All rights reserved.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController {
    
    var realm = try! Realm()

    var isResults = false
    private var results: Results<UserResults>?
    private var randomNum: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        createRandomArray()
        loadScores()
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    func createRandomArray() {
        let number = Int.random(in: 1 ... 20)
        for _ in 0 ... number {
            randomNum.append(String(Int.random(in: 1 ... 10)))
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DataViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.text = isResults ? results?[indexPath.row].score : randomNum[indexPath.row]
            destinationVC.gameTime = isResults ? (results?[indexPath.row].gameTime)! : ""
            destinationVC.date = isResults ? convertDate((results?[indexPath.row].date)!) : ""
        }
        
    }
    
    func convertDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy\nHH:mm:ss"
        return formatter.string(from: date)
    }
    
    func loadScores() {
        results = realm.objects(UserResults.self).sorted(byKeyPath: "score", ascending: true)
        
        tableView.reloadData()
    }

}

//MARK: - TableView methods

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isResults ? results!.count : randomNum.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToData", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        
        cell.setUp(with: (isResults ? (results?[indexPath.row].score)! : randomNum[indexPath.row]))
        
        return cell
    }
    
}
