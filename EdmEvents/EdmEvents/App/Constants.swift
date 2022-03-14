//
//  Constants.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/7/22.
//

import Foundation


enum AppError: String {
	case URLImproperFormat = "url not formatted properly"
}

struct K {
	static let UserDefaults_Favorites: String 	= "Favorites"
	static let UserDefaults_Location: String 	= "DefaultLocation"
	static let Location_Cell_Identifier: String = "LocationCell"
	
}

enum AppUIColor: String {
	case Button 		= "Button"
	case SecondaryLabel = "SecondaryLabel"
	case Accent 		= "Accent"
	case OpenScreenText = "OpenText"
}


