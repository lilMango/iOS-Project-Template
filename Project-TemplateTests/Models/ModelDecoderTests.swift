//
//  ModelDecoderTests.swift
//  Project-TemplateTests
//
//  Created by Miguel Paysan on 7/5/21.
//

import XCTest
@testable import Project_Template

class VideosListTest: XCTestCase {
    func testSuccessParser() {
        let json = """
        {
            "videos": [
                {
                    "id": 950,
                    "name": "How to Train a Dragon",
                    "thumbnail": "https://placeimg.com/640/640/nature",
                    "description": "Loremmmmm fipafaf sf asdf sa sgsag sag",
                    "video_link": "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
                },
                {
                    "id": 951,
                    "name": "How to Train a Dragon 2",
                    "thumbnail": "https://placeimg.com/640/640/nature",
                    "description": "LoremmmmmDragon asdf sa sgsag sag",
                    "video_link": "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
                }
            ]
        }
        """.data(using: .utf8)!
        
        let response = try! JSONDecoder().decode(PostResponse.self, from: json)
        
        XCTAssertNotNil(response)
        XCTAssertEqual(response.videos.count, 2)
    }
    
    //missing id attribute
    func testFailedParser_MissingID() {
        let json = """
        {
            "videos": [
                {
                    "name": "How to Train a Dragon 2",
                    "thumbnail": "https://placeimg.com/640/640/nature",
                    "description": "LoremmmmmDragon asdf sa sgsag sag",
                    "video_link": "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
                }
            ]
        }
        """.data(using: .utf8)!
//        Thread 1: Fatal error: 'try!' expression unexpectedly raised an error: Swift.DecodingError.keyNotFound(CodingKeys(stringValue: "id", intValue: nil), Swift.DecodingError.Context(codingPath: [CodingKeys(stringValue: "videos", intValue: nil), _JSONKey(stringValue: "Index 0", intValue: 0)], debugDescription: "No value associated with key CodingKeys(stringValue: \"id\", intValue: nil) (\"id\").", underlyingError: nil))
        
        XCTAssertThrowsError(try JSONDecoder().decode(PostResponse.self, from: json))

        do {
            let _ = try JSONDecoder().decode(PostResponse.self, from: json)
        } catch is DecodingError {
            //Successfuly passing
            return
        } catch (let err) {
            XCTFail("Expected Decoding Error. Actual \(err) instead")
        }
        //Swift.DecodingError.keyNotFound
        
    }
}
