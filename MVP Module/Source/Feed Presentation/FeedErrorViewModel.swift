//
//  File.swift
//  MVP
//
//  Created by Fei Wen on 6/12/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

struct FeedErrorViewModel {
	let isError: Bool
	
	var loadError: String {
		Localized.Feed.loadError
	}
}

