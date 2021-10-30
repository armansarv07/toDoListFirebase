//
//  ViewController.swift
//  LoveCalculator
//
//  Created by Arman on 26.10.2021.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var resultDescriptionLabel: UILabel!
    @IBOutlet weak var pairLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var resultButtonOutlet: UIButton! {
        didSet {
            // adjusting corners
            resultButtonOutlet.layer.cornerRadius = 20
            resultButtonOutlet.layer.masksToBounds = true
            
            // adding shadows
            resultButtonOutlet.layer.shadowOffset = CGSize(width: 0, height: 5)
            resultButtonOutlet.layer.shadowOpacity = 1
            resultButtonOutlet.layer.shadowRadius = 20
        }
    }
    
    
    var networkManager = PairNetworkManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.onCompletion = {[weak self] currentPair in
            guard let self = self else {return}
            self.updateInterface(pair: currentPair)
        }
        networkManager.fetchCurrentPair(fname: "Me", sname: "Burgers")
    }
    
    func updateInterface(pair: CurrentPair) {
        DispatchQueue.main.async {
            if self.perfectCase(sname: pair.sname, fname: pair.fname) {
                self.progressView.progress = 1
                self.imageView.image = UIImage(systemName: "bolt.heart.fill")
                self.resultDescriptionLabel.text = "This pair is the most perfect in this universe"
                self.pairLabel.text = "\(pair.fname) and \(pair.sname)"
                self.percentageLabel.text = "999%"
            } else {
                self.pairLabel.text = "\(pair.fname) and \(pair.sname)"
                self.imageView.image = UIImage(systemName: pair.systemIconString)
                self.resultDescriptionLabel.text = pair.result
                self.percentageLabel.text = "\(pair.percentage)%"
                self.progressView.progress = Float(pair.percentage)! / 100
            }
        }
    }
    
    @IBAction func requestResult(_ sender: UIButton) {
        self.presentInsertNamesAlertController(withTitle: "Enter pair names", message: nil, style: .alert) { fname, sname in
            self.networkManager.fetchCurrentPair(fname: fname, sname: sname)
        }
    }
}
