//
//  TableViewCell.swift
//  Memory
//
//  Created by Tyoma Zagoskin on 15/04/2019.
//  Copyright © 2019 Тёма Загоскин. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    
    func setUp(with method: String) {
        name.text = method
    }
}
