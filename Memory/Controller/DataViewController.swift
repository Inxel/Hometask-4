//
//  DataViewController.swift
//  Memory
//
//  Created by Tyoma Zagoskin on 15/04/2019.
//  Copyright © 2019 Тёма Загоскин. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var number: UILabel! {
        didSet {
            number.text = text
        }
    }
    
    @IBOutlet weak var gameTimeLabel: UILabel! {
        didSet {
            gameTimeLabel.text = gameTime != "" ? "Your game time: \(gameTime!) seconds" : ""
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.text = date
        }
    }
    
    var text: String?
    var date: String?
    var gameTime: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
