//
//  JokeViewController.swift
//  DadJokesAPI
//
//  Created by Keith Mair on 4/6/22.
//

import UIKit

class JokeViewController: UIViewController {
    
    @IBOutlet weak var jokeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView() {
        
        JokeController.fetchDadJoke { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let joke):
                    self.jokeLabel.text = joke
                    
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    @IBAction func nextJokeButtonTapped(_ sender: Any) {
        updateView()
    }
} // End of class
