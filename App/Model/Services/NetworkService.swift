//
//  NetworkService.swift
//  TestAppForAvito
//
//  Created by Mac on 04.09.2021.
//

import Foundation

//протокол нужен для последующих возможных новых запросов, чтобы мы использовали зависимость с протоколом и классами, которые их реализуют, а не просто с классами
protocol Networking {
    func request(completion: @escaping (Data?, Error?)  -> Void)
}

class NetworkService: Networking {
    

    
    //тут выполняется запрос по url (request)
    // (Data?, Error?) -> либо data = nil и выведется error, либо error = nil и выведется data
     func request(completion: @escaping (Data?, Error?)  -> Void) {
        guard let url = URL(string: "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c") else { return }
        
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    //тут создается task отдельно для запроса (request)
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        
        return URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                //либо data = nil и выведется error, либо error = nil и выведется data
                completion(data, error)
            }
        }
    }
    //следующий шаг -> NetworkDataFetcher 
}


