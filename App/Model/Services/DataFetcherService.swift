//
//  DataFetcherService.swift
//  TestAppForAvito
//
//  Created by Mac on 05.09.2021.
//

import Foundation

class DataFetcherService {
    
    static let shared = DataFetcherService()
    
    //нужен если будут не с интернета браться данные, а локально и тд. Поэтому не класс NetworkDataFetcher у нас, а протокол DataFetcher
    var dataFetcher: DataFetcher
    
    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
    
    
    //тут уже выполняется вся логика и этот файл мы используем для комплишена в других файлах
    //это уже реальный запрос
    //тут мы будем создавать еще другие запросы любые вообще с любыми моделями
    func fetchData (completion: @escaping (Welcome?) -> Void) {
        
        dataFetcher.fetchGenericData(completion: completion)
    }
}
