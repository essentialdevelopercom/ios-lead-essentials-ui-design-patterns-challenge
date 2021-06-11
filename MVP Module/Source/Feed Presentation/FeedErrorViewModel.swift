//
//  FeedErrorViewModel.swift
//  MVP
//
//  Created by Maciej Krolikowski on 12/05/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

struct FeedErrorViewModel {
	let message: String?

	static var noError: FeedErrorViewModel {
		return FeedErrorViewModel(message: nil)
	}

	static func error(message: String) -> FeedErrorViewModel {
		return FeedErrorViewModel(message: message)
	}
}
