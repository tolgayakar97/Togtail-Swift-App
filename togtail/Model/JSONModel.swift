//
//  JSONModel.swift
//  togtail
//
//  Created by Tolga Yakar on 24.01.2024.
//

import Foundation

struct JSONModel{
    
    private let parser:  JSONDecoder
    
    init() {
        parser = JSONDecoder()
    }
    
    //Generic method for parsing JSON data.
    func parseJSON<T: Codable>(modelType: T.Type, data: Data) -> T?
    {
        do {
            //Decoding process within try catch block.
            let getData = try parser.decode(T.self, from: data)
            return getData
        }
        catch{
            print(error)
            return nil
        }
    }
}


