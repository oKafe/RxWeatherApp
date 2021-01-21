//
//  CurrentWeatherModel.swift
//  RxWeather
//
//  Created by Andy Orphan on 20.01.2021.
//

import Foundation
import Mapper

struct CurrentWeather: Mappable {
    
    let name: String
    let cod: Int
    let id: Int
    let coord: Coord
    let mainWeather: MainWeather
    let wind: Wind
    
    init(map: Mapper) throws {
        try name = map.from("name")
        try coord = map.from("coord")
        try mainWeather = map.from("main")
        try wind = map.from("wind")
        try id = map.from("id")
        try cod = map.from("cod")
    }
}

struct Coord: Mappable {
    
    let lon: Double
    let lat: Double
    
    init(map: Mapper) throws {
        try lon = map.from("lon")
        try lat = map.from("lat")
    }
    
    
}

struct MainWeather: Mappable {
    
    let temp: Double
    let feelsLikeTemp: Double
    let minTemp: Double
    let maxTemp: Double
    let pressure: Int
    let humidity: Int
    
    init(map: Mapper) throws {
        try temp = map.from("temp")
        try feelsLikeTemp = map.from("feels_like")
        try minTemp = map.from("temp_min")
        try maxTemp = map.from("temp_max")
        try pressure = map.from("pressure")
        try humidity = map.from("humidity")
    }
    
    
}

struct Wind: Mappable {
    
    let speed: Double
    let deg: Int
    
    init(map: Mapper) throws {
        try speed = map.from("speed")
        try deg = map.from("deg")
    }
    
    
}

//struct Sys: Mappable {
//
//    init(map: Mapper) throws {
//        <#code#>
//    }
//
//
//}
