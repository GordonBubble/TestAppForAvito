//
//  ViewController.swift
//  TestAppForAvito
//
//  Created by Mac on 03.09.2021.
//

import UIKit
import Foundation
class ViewController: UIViewController {
    
    private var employees: [Employee] = []
    
    @IBOutlet weak var tableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    }
}


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



extension ViewController {
     func getData() {
        DataFetcherService.shared.fetchData { [weak self] welcome in
            guard let self = self else { return }
            
            if welcome != nil {
                self.employees = welcome?.company.employees
                    .map({$0})
                    .sorted(by: { $0.name < $1.name}) ?? []
                self.tableView.reloadData()
                self.networkStatus(to: true)
            } else {
                self.networkStatus(to: false)
                
            }
        }
    }
}
