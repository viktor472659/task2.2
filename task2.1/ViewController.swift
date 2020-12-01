//
//  ViewController.swift
//  task2.1
//
//  Created by Viktor on 01.12.2020.
//  Copyright © 2020 Viktor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var movies = [Movie]()
    let fetcher = MovieStore.shared
    
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var labelText: UILabel!
    
    @IBAction func buttonField(_ sender: UIButton) {
        print(inputField.text ?? "")
        
        if(inputField.text==""){return}
        
        fetcher.searchMovie(query: inputField.text ?? "") { (result) in
            switch result {
            case .success(let response):
                self.movies = response.results
                self.tableView.reloadSections([0], with: .none)
                if(self.movies.count==0){
                    self.labelText.text = "Збігів не знайдено"
                }else {
                    self.labelText.text = "Ваші фільми"
                }
            case .failure(let error):
                print("Error - \(error)")
                self.tableView.reloadSections([0], with: .none)
            }
         }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TableViewCell.nib(), forCellReuseIdentifier: "TableViewCell")
        tableView.delegate = self
        tableView.dataSource = self

    }


}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let detailsViewController = storyBoard.instantiateViewController(withIdentifier: "detailsViewController") as! DetailsViewController
        detailsViewController.idOfMovie = movies[indexPath.item].id
        
            detailsViewController.modalPresentationStyle = .fullScreen
            self.present(detailsViewController, animated:true, completion:nil)
    }
}

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        cell.setup(with: movies[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(300)
    }
    
}
