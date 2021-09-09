//
//  TableViewDelegateAndDataSource.swift
//  TestAppForAvito
//
//  Created by Mac on 07.09.2021.
//

import Foundation
import UIKit


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let people = employees[indexPath.row]

        cell.nameLabel.text = "Name: " + people.name
        cell.phoneLabel.text = "Phone: " + people.phoneNumber
        cell.skillsLabel.text = String(people.skills.flatMap({$0 + "; "}))
        
        return cell
    }
}
