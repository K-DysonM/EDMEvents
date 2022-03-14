//
//  MainCoordinator.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/11/22.
//

import Foundation
import UIKit
import MapKit

class MainCoordinator: Coordinator {
	var nav: UINavigationController
	var tabBarController: UITabBarController
	
	var children = [Coordinator]()
	var eventsViewModel: EventsViewModel
	
	init() {
		self.eventsViewModel = EventsViewModel()
		self.nav = UINavigationController()
		self.tabBarController = UITabBarController()
	}
	
	func start() -> UIViewController {
		tabBarController.tabBar.scrollEdgeAppearance = tabBarController.tabBar.standardAppearance
		tabBarController.tabBar.tintColor = UIColor(named: AppUIColor.Button.rawValue)
	
		let homeCoordinator = HomeCoordinator(main: self)
		children.append(homeCoordinator as Coordinator)
		let tab1 = homeCoordinator.start()
		tab1.tabBarItem = .init(title: "Home", image: UIImage(systemName: "house"), tag: 0)
		
	
		let favoriteCoordinator = FavoriteCoordinator(main: self)
		children.append(favoriteCoordinator as Coordinator)
		let tab2 = favoriteCoordinator.start()
		tab2.tabBarItem =  .init(title: "Favorites", image: UIImage(systemName: "heart"), tag: 1)
		
		tabBarController.viewControllers = [tab1, tab2]
		return tabBarController
	}
}
