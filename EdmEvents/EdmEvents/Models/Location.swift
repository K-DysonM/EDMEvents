//
//  Location.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/7/22.
//

import Foundation

struct Location: Codable {
	var id: Int
	var city: String?
	var state: String
	var stateCode: String
	var latitude: Double
	var longitude: Double
	var link: String
}
