//
//  FeedErrorViewModel.swift
//  MVP
//
//  Created by Danil Lahtin on 16.05.2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

struct FeedErrorViewModel {
	let message: String?

	private init(message: String?) {
		self.message = message
	}

	static var noError: FeedErrorViewModel {
		FeedErrorViewModel(message: nil)
	}

	static func message(_ message: String) -> FeedErrorViewModel {
		FeedErrorViewModel(message: message)
	}
}
