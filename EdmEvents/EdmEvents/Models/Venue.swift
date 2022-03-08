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
