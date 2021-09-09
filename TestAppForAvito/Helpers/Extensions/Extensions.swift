//
//  Extensions.swift
//  TestAppForAvito
//
//  Created by Mac on 06.09.2021.
//

import Foundation
import UIKit
import Network


extension ViewController {
    
    
    //MARK: - Некорректно работает в симуляторе, причина неизвестна. Отлично работает на реальном устройстве.
    func monitorNetworkAndGetData() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue.global()
        monitor.start(queue: queue)
        
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            
            if path.status == .satisfied {
                print("connected")
                self.getData()
            } else {
                print("not connected")
                
                DispatchQueue.main.async {
                    self.alert()
                }
                self.getData()
            }
        }
    }
    
    //create alertController for bad internet
    func alert() {
        
        let alert = UIAlertController(title: "Отсутствует интернет", message: "Бро, проверь интернет", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
        }
    }

