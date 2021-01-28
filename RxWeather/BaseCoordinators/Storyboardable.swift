//
//  Storyboardable.swift
//  RxWeather
//
//  Created by Andy Orphan on 28.01.2021.
//

import Foundation
import UIKit

import UIKit

protocol Storyboardable {
    static var storyboardIdentifier: String { get }
}

extension Storyboardable where Self: UIViewController {

    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }

    static func initFromStoryboard(name: String = "Main") -> Self {
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
}
