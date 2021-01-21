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
    
    let disposeBag = DisposeBag()
    var provider: MoyaProvider<WeatherEndpoints>!
    var searchWeatherModel: SearchWeatherModel!
    
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
        setup()
    }
    
    private func setup() {
        
        provider = MoyaProvider<WeatherEndpoints>()
        
        searchWeatherModel = SearchWeatherModel(rxProvider: provider, cityName: latestCityName)
        
        searchWeatherModel
            .findWeather()
            .map { $0 }
            .bind(onNext: { (model) in
                self.configureUI(model: model)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureUI(model: CurrentWeather?) {
        print(model?.name)
    }


}

