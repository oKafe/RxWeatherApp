//
//  SearchWeatherCoordinator.swift
//  RxWeather
//
//  Created by Andy Orphan on 28.01.2021.
//

import Foundation
import UIKit
import RxSwift
import Moya
import Moya_ModelMapper

class SearchWeatherCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        
        let searchWeatherVC = SearchWeatherVC.initFromStoryboard()
        let navigationController = UINavigationController(rootViewController: searchWeatherVC)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        return Observable.never()
    }
    
}


 
