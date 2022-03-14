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
		return Venue(id: 809,
					 name: "Skully's Music Diner",
					 location: "Columbus, OH",
					 address: "1151 N High St, Columbus, OH 43201, USA",
					 state: "Ohio",
					 latitude: 39.986,
					 longitude: -83.006)
	}
}
