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
extension Location: Equatable, MockData {
	static func fake() -> Location {
		return Location(id: 69,
						city: "Las Vegas",
						state: "Nevada",
						stateCode: "NV",
						latitude: 36.17,
						longitude: -115.14,
						link: "https://edmtrain.com/las-vegas-nv")
	}
	//Compares all properties except the unique id
	static func ==(lhs: Location, rhs: Location) -> Bool {
		return lhs.city == rhs.city && lhs.state == rhs.state
		&& lhs.stateCode == rhs.stateCode && lhs.latitude == rhs.latitude
		&& lhs.longitude == rhs.longitude
	}
}
