//
//  PostResponseMock.swift
//  Project-TemplateTests
//
//  Created by Miguel Paysan on 7/5/21.
//

import Foundation
@testable import Project_Template

extension PostResponse {
    
    static func mockVideosArray() -> [Video] {
        return [Video.with(id: "100"), Video.with(id: "101")]
    }
    
    static func mockPostResponse() -> PostResponse {
        return PostResponse(videos: [Video.with(id: "100"), Video.with(id: "101")])
    }
}
