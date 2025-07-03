//
//  GetLastCopiedItemResponse.swift
//  Echo
//
//  Created by Ananjan Mitra on 13/06/25.
//

import Foundation

struct GetLastCopiedItemResponse: Decodable {
    var result: GetLastCopiedItemResponseResult
    
    struct GetLastCopiedItemResponseResult: Decodable {
        var data: GetLastCopiedItemResponseResultData
    }
    
    struct GetLastCopiedItemResponseResultData: Decodable {
        var json: GetLastCopiedItemResponseResultDataJson
    }
    
    struct GetLastCopiedItemResponseResultDataJson: Decodable {
        var item: String
        var device: String
    }
}

