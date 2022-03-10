//
//  Venue.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/7/22.
//

import Foundation

struct Venue: Codable {
	var id: Int
	var name: String
	var location: String
	var address: String?
	var state: String?
	var latitude: Float?
	var longitude: Float?
}
extension Venue {
	static func fake() -> Self {
		return Venue(id: 1,
					 name: "The Venue Name",
					 location: "City, SC",
					 address: "Address, City, SC Zip, Country",
					 state: "The State",
					 latitude: 40.67,
					 longitude: -73.996)
	}
}
