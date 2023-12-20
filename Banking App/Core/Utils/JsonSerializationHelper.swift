//
//  JsonSerializationHelper.swift
//  Banking App
//
//  Created by Kanan Abilzada on 19.12.23.
//

import Foundation

protocol JSONHelperProtocol: AnyObject {
   func decode<T: Decodable>(jsonData: Data, type: T.Type) -> T?
   func encode<T: Encodable>(encodable: T) -> Data?
}

class JSONHelper: JSONHelperProtocol {
   func encode<T>(encodable: T) -> Data? where T : Encodable {
      let jsonEncoder = JSONEncoder()
      return try? jsonEncoder.encode(encodable)
   }
   
   func decode<T: Decodable>(jsonData: Data, type: T.Type) -> T? {
       let jsonDecoder = JSONDecoder()
       return try? jsonDecoder.decode(T.self, from: jsonData)
   }
}
