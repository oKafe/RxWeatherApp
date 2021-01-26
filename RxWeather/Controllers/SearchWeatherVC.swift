//
//  ViewController.swift
//  RxWeather
//
//  Created by Andy Orphan on 20.01.2021.
//

import UIKit
import RxCocoa
import RxSwift
import Moya
import Moya_ModelMapper

class SearchWeatherVC: UIViewController {

    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    let disposeBag = DisposeBag()
    var provider: MoyaProvider<WeatherEndpoints>!
    var searchWeatherVM: SearchWeatherVM!
    
    var latestCityName: Observable<String> {
        return searchTF
            .rx
            .text
            .filterNil()
            .filter({ (text) -> Bool in
                if text.count > 2 {
                    return true
                }
                return false
            })
            .distinctUntilChanged()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    private func setupViewModel() {
        
        provider = MoyaProvider<WeatherEndpoints>()
        
        searchWeatherVM = SearchWeatherVM(provider: provider, cityName: latestCityName)
        
        searchWeatherVM
            .findWeather()
            .map { $0 }
            .bind(onNext: { (weatherStrings) in
                self.configureUI(weatherStrings)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureUI(_ weatherStrings: WeatherStrings?) {
        self.cityNameLabel.text = weatherStrings?.cityName
        self.minTempLabel.text = weatherStrings?.minTemp
        self.maxTempLabel.text = weatherStrings?.maxTemp
        self.currentTempLabel.text = weatherStrings?.temp
        self.humidityLabel.text = weatherStrings?.humidity
        self.feelsLikeLabel.text = weatherStrings?.feelsLikeTemp
    }


}

