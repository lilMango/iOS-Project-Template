//
//  VideosService.swift
//  Project-Template
//
//  Created by Miguel Paysan on 7/5/21.
//

import Foundation
import Combine

protocol VideosService {
    func request(from urlstr: String) -> AnyPublisher<PostResponse, APIError>
}


struct VideosServiceImpl: VideosService {
    func request(from urlstr: String) -> AnyPublisher<PostResponse, APIError> {
        //URL(string: K.IPS_VIDEOS_URL)
        return URLSession
            .shared
            .dataTaskPublisher(for: URL(string: urlstr)!)
            .receive(on: DispatchQueue.main)
            .mapError { _ in APIError.unknown}
            .flatMap { data, response -> AnyPublisher<PostResponse,APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                if (200...299).contains(response.statusCode) {
                    return Just(data)
                        .decode(type: PostResponse.self, decoder: JSONDecoder())
                        .mapError { _ in APIError.decodingError}
//                        .map (\PostResponse.videos)//using key path references instead of closures, since it's cleaner
                        .eraseToAnyPublisher()
                        
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}

