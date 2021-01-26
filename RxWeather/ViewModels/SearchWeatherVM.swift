//
//  SearchWeatherModel.swift
//  RxWeather
//
//  Created by Andy Orphan on 20.01.2021.
//

import Foundation
import Moya
import Mapper
import Moya_ModelMapper
import RxOptional
import RxSwift

struct WeatherStrings {
    let temp: String
    let feelsLikeTemp: String
    let minTemp: String
    let maxTemp: String
    let humidity: String
    let cityName: String
}

class SearchWeatherVM: NSObject {
    let rxProvider: MoyaProvider<WeatherEndpoints>
    let cityName: Observable<String>
    private var currentWeather: CurrentWeather?
    
    init(provider: MoyaProvider<WeatherEndpoints>, cityName: Observable<String>) {
        self.rxProvider = provider
        self.cityName = cityName
        super.init()
    }
    
    func findWeather() -> Observable<WeatherStrings?> {
        return cityName
            .observeOn(MainScheduler.instance)
            .flatMapLatest { (name) -> Observable<WeatherStrings?> in
                return self.getWeather(cityName: name)
            }
    }
    
    func convertWeather(_ model: CurrentWeather?) -> Observable<WeatherStrings?> {
            
        
            guard let weatherModel = model else { return Observable.of(nil) }
            let tempString = "\(Int(weatherModel.mainWeather.temp))℃"
            let humidityString = "Humidity: \(weatherModel.mainWeather.humidity)%"
            let minTempString = "Min:\(Int(weatherModel.mainWeather.minTemp))℃"
            let maxTempString = "Max:\(Int(weatherModel.mainWeather.maxTemp))℃"
            let feelsLikeString = "Feels like: \(Int(weatherModel.mainWeather.feelsLikeTemp))℃"
            let weatherStrings = WeatherStrings(temp: tempString, feelsLikeTemp: feelsLikeString, minTemp: minTempString, maxTemp: maxTempString, humidity: humidityString, cityName: weatherModel.name)
            return Observable.of(weatherStrings)
    }
    
    private func getWeather(cityName: String) -> Observable<WeatherStrings?> {
        return rxProvider.rx
            .request(WeatherEndpoints.CurrentWeather(query: cityName))
            .debug()
            .mapOptional(to: CurrentWeather.self)
            .asObservable()
            .flatMapLatest { (weather) -> Observable<WeatherStrings?> in
                return self.convertWeather(weather)
            }
    }
    
}
