//
//  Pair.swift
//  LoveCalculator
//
//  Created by Arman on 26.10.2021.
//

import Foundation

struct CurrentPair {
    let fname, sname, percentage, result: String
    var conditionCode: Int {
        let code = Int(percentage)!
        return code
    }
    
    var systemIconString: String {
        switch conditionCode {
        case 0...20:
            return "heart.slash.fill"
        case 21...40:
            return "exclamationmark.triangle"
        case 41...60:
            return "person.fill"
        case 61...80:
            return "smiley.fill"
        case 81...100:
            return "heart.fill"
        default:
            return "bolt.heart.fill"
        }
    }
    
    init?(currentPair: CurrentPairData) {
        fname = currentPair.fname
        sname = currentPair.sname
        percentage = currentPair.percentage
        result = currentPair.result
    }
}
