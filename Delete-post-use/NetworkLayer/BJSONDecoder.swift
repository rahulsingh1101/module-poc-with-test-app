//
//  BJSONDecoder.swift
//  Delete-post-use
//
//  Created by Rahul Singh on 31/05/25.
//


import Foundation

final class BJSONDecoder<T: Decodable> {
    private let jsonDecoder = JSONDecoder()

    func decode(from data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
