//
//  FeedErrorStateViewModel.swift
//  MVP
//
//  Created by Erik Agujari on 23/2/21.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

enum FeedErrorState {
	case hidden
	case shown(message: String)
}

struct FeedErrorStateViewModel {
	let state: FeedErrorState
}
