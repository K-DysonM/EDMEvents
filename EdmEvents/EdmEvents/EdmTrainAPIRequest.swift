//
//  EdmTrainAPIRequest.swift
//  EdmEvents
//
//  Created by Kiana Dyson on 3/7/22.
//

import Foundation
import UIKit


struct EdmTrainAPIRequest {
	let url: URL
	
	func perform<T: Decodable>(with completion: @escaping (T?, Error?) -> Void) {
		let session = URLSession(configuration: .default)
		
		let task = session.dataTask(with: url) { data, response, error in
			guard error == nil else { completion(nil, error); return }
			
			if let data = data{
				let decoder = JSONDecoder()
				let decodedData = try? decoder.decode(T.self, from: data)
				completion(decodedData, nil)
			}
		}
		task.resume()
	}
}
enum EdmApiResultCode {
	case invalidAppKey
	case locationNotFound
	case unknown(String)
}
extension EdmApiResultCode {
	static func code(for string: String) -> EdmApiResultCode {
		switch string {
		case "Invalid client":   return .invalidAppKey
		case "Location not found": return .locationNotFound
		default:                 return .unknown(string)
		}
	}
}


//Invalid client
//Location not found
