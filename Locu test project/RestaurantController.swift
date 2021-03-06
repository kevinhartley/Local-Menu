//
//  RestaurantController.swift
//  LocuEx
//
//  Created by Habib Miranda on 7/30/16.
//  Copyright © 2016 Falcone Development. All rights reserved.
//

import UIKit

class RestaurantController {
    
    static let sharedInstance = RestaurantController()
    
    var myRestaurant = [Restaurant]()
    
    func getRestaurants() {
        
    }
    
    func fetchLocuData(completion: (restaurants: [Restaurant]) -> Void) {
        
        guard let baseURL = NSURL(string: "https://api.locu.com/v2/venue/search/") else {
            completion(restaurants: [])
            return
        }
        
        let bodyDict = ["fields": ["name", "menu_url", "contact", "website_url", "extended", "open_hours", "location"],
                        "venue_queries": [["categories" : ["name": "burgers"]]],
                        "api_key": "44be813e6e30f7c82da90e5369aa0618ac294d73"]
        
        guard let data = try? NSJSONSerialization.dataWithJSONObject(bodyDict, options: .PrettyPrinted) else {
            return
        }
        
        NetworkController.performRequestForURL(baseURL, httpMethod: .Post, body: data) { (data, response, error) in
            guard let _ = response, data = data, serializedData = try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments), dataDictionary = serializedData as? [String: AnyObject] else {
                return
            }
            print(dataDictionary)
            guard let restaurants = dataDictionary["venues"] as? [[String: AnyObject]] else {
                completion(restaurants: [])
                return
            }
            
            
            let restaurantsArray = restaurants.flatMap { Restaurant(dictionary: $0) }
            restaurantsArray.forEach { print($0.name) }
            restaurantsArray.forEach { print($0.menuURL) }
            
            //            _ = restaurants.flatMap { Restaurant(dictionary: $0) }
            completion(restaurants: restaurantsArray)
        }
    }
}
