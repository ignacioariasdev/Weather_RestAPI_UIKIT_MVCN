//
//  WeatherJSON.swift
//  Weather_RestAPI_UIKIT_MVCN
//
//  Created by Ignacio Arias on 2020-07-13.
//  Copyright © 2020 Ignacio Arias. All rights reserved.
//

/*

{
   "coord":{
      "lon":-0.13,
      "lat":51.51
   },
   "weather":[
      {
         "id":803,
         "main":"Clouds",
         "description":"broken clouds",
         "icon":"04n"
      }
   ],
   "base":"stations",
   "main":{
      "temp":15.86,
      "feels_like":14.21,
      "temp_min":14.44,
      "temp_max":17,
      "pressure":1007,
      "humidity":82
   },
   "visibility":10000,
   "wind":{
      "speed":3.6,
      "deg":230
   },
   "clouds":{
      "all":54
   },
   "dt":1593639668,
   "sys":{
      "type":1,
      "id":1414,
      "country":"GB",
      "sunrise":1593575265,
      "sunset":1593634849
   },
   "timezone":3600,
   "id":2643743,
   "name":"London",
   "cod":200
}

*/

import Foundation


//Lets decode image later on and store in core data as well.
struct WeatherJSON: Codable {
    
    let name: String
    let wind: Wind
}

struct Wind: Codable {
    
    let speed: Double
}
