//
//  API.swift
//  GreenGear
//
//  Created by Anika Morris on 7/1/20.
//  Copyright © 2020 Anika Morris. All rights reserved.
//

import Foundation

class API {
    
    func createUser(user: User, _ completion: @escaping (Result<Any>) -> ()) {
        let session = URLSession.shared
        let url = URL(string: "https://green-gear-ld.herokuapp.com/api/user/create/")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let jsonData = try! JSONEncoder().encode(user)
        request.httpBody = jsonData
        
        session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if error != nil { print("POST Request: Communication error: \(error!)") }
//            Response.handleResponse(for: response as! HTTPURLResponse)
            if data != nil {
                do {
                    let resultObject = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                    let result = resultObject["result"] as? [String: Any]
                    let id = result?["_id"]
                    DispatchQueue.main.async(execute: {
                        completion(Result.success(id as Any))
                    })
                } catch {
                     DispatchQueue.main.async(execute: {
                        completion(Result.failure(NetworkError.couldNotParse))
                     })
                }
            } else {
                DispatchQueue.main.async(execute: {
                    completion(Result.failure(NetworkError.noResponse))
                })
            }
        }).resume()
    }
    
    // Saves new post to the database with user's username
    func newPost() {
        let session = URLSession.shared
        let url = URL(string: "https://green-gear-ld.herokuapp.com/api/user/create/")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
    }
    
    // Returns all posts in the database
    func getAllPosts(_ completion: @escaping (Result<Any>) -> ()) {
        let session = URLSession.shared
        let url = URL(string: "https://green-gear-ld.herokuapp.com/api/post/retrieve/")
        let request = URLRequest(url: url!)
        session.dataTask(with: request) { data, response, error in
            if let error = error { return }
            let responseResult = Response.handleResponse(for: response as! HTTPURLResponse)
            switch responseResult {
            case let .success(message):
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(Result.failure(NetworkError.noData))
                    }
                    return
                }
                let result = try? JSONDecoder().decode(PostAPIResponse.self, from: data)
                guard result != nil else {
                    print("\n" + String(decoding: data, as: UTF8.self))
                    return
                }
//                completion(Result.success(result!.articles))
            case let .failure(error):
                DispatchQueue.main.async {
                    completion(Result.failure(error))
                }
            }
        }
        
    }
    
    // Returns all posts in a particular discussion group
    func getPosts(for discussionGroup: String) {
        
    }
    
    // Returns single post with comments
    func getPost(postId: Int) {
        
    }
    
    // Updates a specific post in the database by finding the post ID
    func updatePost(postId: Int) {
        
    }
    
    func deletePost(postId: Int) {
        
    }

}
