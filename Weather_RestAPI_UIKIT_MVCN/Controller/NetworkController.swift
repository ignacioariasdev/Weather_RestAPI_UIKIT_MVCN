//
//  NetworkController.swift
//  Weather_RestAPI_UIKIT_MVCN
//
//  Created by Ignacio Arias on 2020-07-13.
//  Copyright © 2020 Ignacio Arias. All rights reserved.
//

import UIKit

class NetworkController {
    
    class func requestWeatherData(url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            
            completionHandler(data, nil)
        }
        task.resume()
    }
    
}
