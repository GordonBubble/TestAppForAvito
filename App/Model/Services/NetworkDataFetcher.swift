//
//  NetworkDataFetcher.swift
//  TestAppForAvito
//
//  Created by Mac on 05.09.2021.
//

import Foundation

//протокол нужен для последующих возможных новых запросов, чтобы мы использовали зависимость с протоколом и классами, которые их реализуют, а не просто с классами
//так же протокол нужен если будут не с интернета браться данные, а локально и тд
protocol DataFetcher {
    func fetchGenericData<T: Codable>(completion: @escaping (T?) -> Void)
}

//можно создать класс который наследуется от NetworkDataFetcher и переопределяет его методы fetchGenericData и decodeJSON, чтобы сделать локальную загрузку
class NetworkDataFetcher: DataFetcher {
    
        //тут можно использовать не класс NetworkService, а протокол Networking, под который подписан класс NetworkService
    private var networking: Networking
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }

    
    //связующая функция между NetworkService.request и decodeJSON
    func fetchGenericData<T: Codable>(completion: @escaping (T?) -> Void) {
        
        networking.request { data, error in
            
            let decoded = self.decodeJSON(type: T.self, from: data)
            DispatchQueue.main.async {
                completion(decoded)
            }
        }
    }
    
    
    //тут данные декодируются в понятную для нас модель (функция пытается распарсить данные)
    func decodeJSON<T: Codable> (type: T.Type, from data: Data?) -> T? {
        guard let data = data else { return nil }
        
        do {
            
            let objects = try JSONDecoder().decode(type.self, from: data)
            return objects
            
        } catch let error{
            print("failed to decode JSON \(error.localizedDescription)")
            return nil
        }
    }
    //следующий шаг -> DataFetcherService
}
