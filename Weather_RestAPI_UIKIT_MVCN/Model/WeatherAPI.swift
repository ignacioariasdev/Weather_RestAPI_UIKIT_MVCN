//
//  WeatherAPI.swift
//  Weather_RestAPI_UIKIT_MVCN
//
//  Created by Ignacio Arias on 2020-07-13.
//  Copyright © 2020 Ignacio Arias. All rights reserved.
//

import Foundation

class WeatherAPI {
    
    enum EndPoints {
        static let base = "https://api.openweathermap.org/data/2.5/weather?q="
        
        case getWeatherInfo(cityName: String)
        
        var stringValue: String {
            
            switch self {
                
            case.getWeatherInfo(let cityName): return
                "\(EndPoints.base)\(cityName)&appid=dd9b28654c5a034286b8c15ee2a26830&units=metric"
                
            }
            
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
        
    }
}
