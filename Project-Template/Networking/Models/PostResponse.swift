//
//  PostResponse.swift
//  Project-Template
//
//  Created by Miguel Paysan on 7/5/21.
//

import Foundation

struct PostResponse: Codable {
    let videos: [Video]
    
    public init(videos:[Video]) {
        self.videos = videos
    }
}
