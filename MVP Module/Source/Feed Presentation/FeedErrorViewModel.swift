//
//  FeedErrorViewModel.swift
//  MVP
//
//  Created by Nicolas De Maio on 19/11/20.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

struct FeedErrorViewModel {
    let message: String?
    
    var hasMessage: Bool {
        return message != nil
    }
}
