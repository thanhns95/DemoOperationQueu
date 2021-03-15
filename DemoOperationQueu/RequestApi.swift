//
//  RequestApi.swift
//  DemoOperationQueu
//
//  Created by Nguyễn Thành on 14/03/2021.
//  Copyright © 2021 TrungNguyen. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class CallBaseApi: NSObject {
    class var sharedInstance: CallBaseApi {
        struct Singleton {
            static let instance = CallBaseApi()
        }
        return Singleton.instance
    }
    func getAlbum<T:Mappable>(success: @escaping (T) -> Void) {
        guard let url = URL(string: "https://my-json-server.typicode.com/congeovi/albums/db") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            guard let jsonData = try? JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String: Any] else {return}
            if let result = Mapper<T>().map(JSON: jsonData) {
                success(result)
            }
        }
        task.resume()
    }
    
    func getPhotos<T:Mappable>(success: @escaping (T) -> Void) {
        guard let url = URL(string: "https://my-json-server.typicode.com/congeovi/photos/db") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            guard let jsonData = try? JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String: Any] else {return}
            if let result = Mapper<T>().map(JSON: jsonData) {
                success(result)
            }
        }
        task.resume()
    }
    
    func download(from url: String, completion: @escaping (Data) -> Void) -> URLSessionDataTask? {
        guard let url = URL(string: url) else { return nil }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else { return }
            completion(data)
        })
        return task
    }
    
}
