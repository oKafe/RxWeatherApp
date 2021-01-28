//
//  AppCoordinator.swift
//  RxWeather
//
//  Created by Andy Orphan on 28.01.2021.
//

import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    override func start() -> Observable<Void> {
        let searchWeatherCoordinator = SearchWeatherCoordinator(window: window)
        return coordinate(to: searchWeatherCoordinator)
    }
}



    


 

