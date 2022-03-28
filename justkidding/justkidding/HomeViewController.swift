//
//  ViewController.swift
//  justkidding
//
//  Created by Vishank Raghav on 28/03/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var getNewButton: UIButton!
    @IBOutlet weak var jokeBgView: UIView!
    @IBOutlet weak var textOneLabel: UILabel!
    @IBOutlet weak var revealButton: UIButton!
    @IBOutlet weak var textTwoLabel: UILabel!
    
    var baseURL = "https://v2.jokeapi.dev/joke/Any"
    var bgColor = [UIColor.red, UIColor.green, UIColor.blue, UIColor.brown, UIColor.cyan, UIColor.magenta, UIColor.orange]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        getJoke()
        // Do any additional setup after loading the view.
    }
    func setUp() {
        textTwoLabel.isHidden = true
        revealButton.isHidden = true
        jokeBgView.layer.cornerRadius = 20
    }
    func getJoke() {
        guard let url = URL(string: baseURL) else {return}
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let response = try JSONDecoder().decode(Joke.self, from: data)
                print(response.safe)
                if let type = response.type, response.safe == true {
                    DispatchQueue.main.async { [self] in
                        self?.jokeBgView.layer.backgroundColor = self?.bgColor.randomElement()?.cgColor
                        self?.jokeBgView.isHidden = false
                        self?.revealButton.isHidden = type == "twopart" ? false : true
                    }
                    switch type {
                    case "single":
                        guard let joke = response.joke else { return }
                        DispatchQueue.main.async {
                            self?.textOneLabel.text = joke
                        }
                    case "twopart":
                        guard let setup = response.setup, let delivery = response.delivery else { return }
                        DispatchQueue.main.async {
                            self?.textOneLabel.text = setup
                            self?.textTwoLabel.text = delivery
                        }
                    default:
                        return
                    }
                } else {
                    self?.getJoke()
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    @IBAction func revealAction(_ sender: UIButton) {
        revealButton.isHidden = true
        textTwoLabel.isHidden = false
    }
    
    @IBAction func getNewAction(_ sender: UIButton) {
        getJoke()
        textTwoLabel.isHidden = true
        jokeBgView.isHidden = true
    }
}

