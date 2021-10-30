//
//  PairNetworkManager.swift
//  LoveCalculator
//
//  Created by Arman on 26.10.2021.
//

import Foundation

class PairNetworkManager {
    var onCompletion: ((CurrentPair) -> Void)?
    func fetchCurrentPair(fname: String, sname: String) {
        let urlString = "https://love-calculator.p.rapidapi.com/getPercentage?sname=\(sname)&fname=\(fname)&rapidapi-key=5cd344ec18mshc20338e900da178p1cdcf0jsn447d8e89590d"
        performRequest(withURLString: urlString)
    }
    
    fileprivate func performRequest(withURLString urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentPair = self.parseJSON(withData: data) {
                    self.onCompletion?(currentPair)
                }
            }
        }
        task.resume()
    }
    
    fileprivate func parseJSON(withData data: Data) -> CurrentPair? {
        let decoder = JSONDecoder()
        do{
            let currentPairData = try decoder.decode(CurrentPairData.self, from: data)
            guard let currentPair = CurrentPair(currentPair: currentPairData) else {return nil}
            return currentPair
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
