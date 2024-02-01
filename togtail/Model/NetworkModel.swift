//
//  NetworkManager.swift
//  togtail
//
//  Created by Tolga Yakar on 24.01.2024.
//
import Foundation

class NetworkModel{
    
    private var _jsonModel : JSONModel
    
    //MARK: Dependency Injection
    
    init() {
        self._jsonModel = JSONModel()
    }
    
    //MARK: Fetching data with letter
    func fetchData<T: Codable>(byLetter letter: String, completion: @escaping (T?) -> Void)
    {
        let url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=\(letter)"

        perfomRequest(url: url, completion: completion)
    }
    
    //Generic method for performing network session and JSON parsing operationn.
    func perfomRequest<T: Codable>(url: String, completion: @escaping (T?) -> Void) {
        
        //Creating an URL instance from provided url string.
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default) //Creating/defining network session.
            
            //Creating a task from created session with url that has been created above.
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    if let data = data {
                        //Because we are in closure, we add self before methods.
                        if let parsedData = self._jsonModel.parseJSON(modelType: T.self, data: data)
                        {
                            //completion is a Completion Handler which performs async operations like fetching data from network.
                            //completion is an escaping function.
                            //"Escaping" in Swift refers to the ability of a closure defined inside a function to be called outside that function at a later time.
                            completion(parsedData)
                            return
                        }
                    }
                }
                else {
                    print(error!)
                }
            }
            
            dataTask.resume()
        }
    }
}
