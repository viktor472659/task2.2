//
//  DetailsViewController.swift
//  task2.1
//
//  Created by Viktor on 01.12.2020.
//  Copyright © 2020 Viktor. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var votedLabel: UILabel!
    
    var movie: Movie?
    let fetcher = MovieStore.shared
    public var idOfMovie: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetcher.fetchMovie(id: idOfMovie ?? -1) { (result) in
           switch result {
           case .success(let response):
            self.setup(with: response)
           case .failure(let error):
               print("Error - \(error)")
           }
        }
    }
    
    
    public func setup(with model: Movie) {
        
        self.titleLabel.text = model.title
        self.yearLabel.text = model.yearText
        
        let data = try! Data(contentsOf: model.posterURL)
        self.imageView?.image = UIImage(data: data)
        
        let component = CircleProgressBar(frame: CGRect(x: (self.circleView.frame.width - 100) / 2, y: (self.circleView.frame.height - 100) / 2, width: 100, height: 100))

        component.progressLvl = model.rating
        component.animate(toValue: CGFloat( model.rating) / 100)

        self.votedLabel.text = "Проголосували: \(model.voteCount)"
        self.descLabel.text = model.overview

        self.circleView.addSubview(component)

    }

}
