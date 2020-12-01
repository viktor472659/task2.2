//
//  TableViewCell.swift
//  task2.1
//
//  Created by Viktor on 01.12.2020.
//  Copyright © 2020 Viktor. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {


    @IBOutlet weak var imageContainerView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var circleView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    static func nib() -> UINib {
        return UINib(nibName: "TableViewCell", bundle: nil)
    }
    
    
    
    public func setup(with model: Movie) {
        
        self.titleLabel.text = model.title
        self.yearLabel.text = model.yearText
        
        do {
            let data = try Data(contentsOf: model.posterURL)
            self.imageContainerView?.image = UIImage(data: data)
        }catch {
            print("Error")
        }
        
        let component = CircleProgressBar(frame: CGRect(x: (self.circleView.frame.width - 100) / 2, y: (self.circleView.frame.height - 100) / 2, width: 100, height: 100))
            component.progressLvl = model.rating
        

        self.circleView.addSubview(component)
       
    }
}
