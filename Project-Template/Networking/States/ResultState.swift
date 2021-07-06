//
//  ResultState.swift
//  Project-Template
//
//  Created by Miguel Paysan on 7/5/21.
//

import Foundation

enum ResultState {
    case loading
    case success(content: [Video])
    case failed(error: Error)
}
