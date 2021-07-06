//
//  MockServices.swift
//  Project-TemplateTests
//
//  Created by Miguel Paysan on 7/5/21.
//

@testable import Project_Template
import XCTest
import Combine


struct MockServiceImpl: VideosService {
    func request(from urlstr: String) -> AnyPublisher<PostResponse, APIError> {
        return Just(PostResponse.mockPostResponse())
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}


struct DecodeErrorMockServiceImpl: VideosService {
    func request(from urlstr: String) -> AnyPublisher<PostResponse, APIError> {
        //data is missing "id" key
        let data = """
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
        
        return Just(data)
            .decode(type: PostResponse.self, decoder: JSONDecoder())
            .mapError { _ in APIError.decodingError}
            .eraseToAnyPublisher()
    }
}

struct ErrorCodeMockServiceImpl: VideosService {
    func request(from urlstr: String) -> AnyPublisher<PostResponse, APIError> {
        return Fail(error: APIError.errorCode(400)).eraseToAnyPublisher()
    }
}

struct UnknownErrorMockServiceImpl: VideosService {
    func request(from urlstr: String) -> AnyPublisher<PostResponse, APIError> {
        return Fail(error: APIError.unknown).eraseToAnyPublisher()
    }
}
