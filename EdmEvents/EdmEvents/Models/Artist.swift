//
//  Artist.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/7/22.
//

import Foundation

struct Artist: Codable {
	var id: Int
	var name: String
	var link: String?
	var b2bInd: Bool
}
extension Artist {
	static func fake() -> Self {
		return Artist(id: 123,
					  name: "The Band Name",
					  link: nil,
					  b2bInd: false)
	}
}
