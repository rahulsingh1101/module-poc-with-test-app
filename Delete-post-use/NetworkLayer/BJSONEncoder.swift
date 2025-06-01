//
//  BJSONEncoder.swift
//  Delete-post-use
//
//  Created by Rahul Singh on 31/05/25.
//

import Foundation

final class BJSONEncoder<T: Encodable> {
    private let jsonDecoder = JSONEncoder()

    func encode(_ value: T) -> Data? {
        do{
            let value = try jsonDecoder.encode(value.self)
            return value
        } catch {
            return nil
        }
    }
}
