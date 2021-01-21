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

struct SearchWeatherModel {
    let rxProvider: MoyaProvider<WeatherEndpoints>
    let cityName: Observable<String>
    
    func findWeather() -> Observable<CurrentWeather?> {
        return cityName
            .observeOn(MainScheduler.instance)
            .flatMapLatest { (name) -> Observable<CurrentWeather?> in
                return self.getWeather(cityName: name)
            }
    }
    
    private func getWeather(cityName: String) -> Observable<CurrentWeather?> {
        return rxProvider.rx
            .request(WeatherEndpoints.CurrentWeather(query: cityName))
            .debug()
            .mapOptional(to: CurrentWeather.self)
            .asObservable()
    }
    
}
