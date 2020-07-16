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
    
    func getUser() {
        
    }
    
    // Returns all posts in the database
    func getAllPosts() {
        
    }
    
    // Returns all posts in a particular discussion group
    func getPosts(for discussionGroup: String) {
        
    }
    
    // Returns single post with comments
    func getPost(postId: Int) {
        
    }
    
    // Saves new post to the database with user's user id
    func newPost() {
        
    }
    
    // Updates a specific post in the database by finding the post ID
    func updatePost(postId: Int) {
        
    }
    
    func deletePost(postId: Int) {
        
    }

}
