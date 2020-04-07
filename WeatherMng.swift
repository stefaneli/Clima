//
//  WeatherMng.swift
//  Clima
//
//  Created by Milos Stefanovic on 04/04/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherMng {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=8c8018f2cc37a14913bb316578283c34"
    
    func fetchWeather (cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performRequest(urlString: urlString)
    }
    
    func performRequest (urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parsJson(weatherData: safeData)
                }
            }
            task.resume()
        }
    }
    
    func parsJson(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let tem = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: tem)
  
            print(weather.temperatureString)
            
        } catch {
            print(error)
        }
        
    }
    

    
}
