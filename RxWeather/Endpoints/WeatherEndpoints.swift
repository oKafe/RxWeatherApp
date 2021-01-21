//
//  WeatherEndpoints.swift
//  RxWeather
//
//  Created by Andy Orphan on 20.01.2021.
//

import Foundation
import Moya

enum Exclude: String {
    typealias RawValue = String
    
    case Current = "current"
    case Minutely = "minutely"
    case Hourly = "hourly"
    case Daily = "daily"
    case Alerts = "alerts"
}

enum WeatherEndpoints {
    case CurrentWeather(query: String)
    case WeatherForecast(exclude: Exclude, coord: Coord)
}

extension WeatherEndpoints: TargetType {
    
    
    var baseURL: URL {
        return URL(string: "http://api.openweathermap.org/data/2.5")!
    }
    
    var path: String {
        switch self {
        case .CurrentWeather(_):
            return "/weather"//?appid=0e6cb9fbea2df1d17d5a9675ebe7492c&q=\(query)
        case .WeatherForecast(let exclude, let coord):
            return "/onecall?lat=\(coord.lat)&lon=\(coord.lon)&exclude=\(exclude)&appid=a4dd4e9a8ddf9ed12cd26e6eba29871d"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
//        switch self {
//        case .CurrentWeather(_):
//
//        case .WeatherForecast(_):
//        }
        return "{\"id\": 420006353, \"name\": \"London\", \"cod\": 200}".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .CurrentWeather(let query):
            return .requestParameters(
                parameters: [
                    "q": query,
                    "appid": "a4dd4e9a8ddf9ed12cd26e6eba29871d"],
                encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }

}
