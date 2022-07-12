//
//  MargaritaViewController.swift
//  CoctailRecepiesAF
//
//  Created by Nikolai Maksimov on 06.07.2022.
//

import UIKit


class MargaritaViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var margaritasTableView: UITableView!
    
    @IBOutlet var loadingView: UIView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var loadingLabel: UILabel!
    
    // MARK: - Public Properties
    var margaritas: [Margarita] = [] {
        didSet {
            self.margaritasTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        margaritasTableView.separatorStyle = .none
        margaritasTableView.showsVerticalScrollIndicator = false
        
        activityIndicator.startAnimating()
        
        NetworkManager.shared.fetchDataWithAlamofire(Link.margaritasUrl.rawValue) { result in
            switch result {
                
            case .success(let margaritas):
                self.margaritas = margaritas
                self.removeLoadingScreen()
            case .failure(let error):
                print(error)
            }
        }
        
        margaritasTableView.delegate = self
        margaritasTableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MargaritaViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        margaritas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "margaritaCell", for: indexPath) as? MargaritaViewCell else { return UITableViewCell() }
        
        let margarita = margaritas[indexPath.row]
        
        cell.margaritasNameLabel.text = margarita.strDrink
        cell.margaritasComponentLabel.text = margarita.composition
        //        cell.margaritasImage.layer.cornerRadius = cell.margaritasImage.frame.height / 2
        cell.margaritasImage.layer.cornerRadius = 20
        cell.selectionStyle = .none
        cell.margaritasImage.layer.borderWidth = 3
        cell.margaritasImage.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0).cgColor
        
        NetworkManager.shared.fetchImage(from: margarita.strDrinkThumb) { result in
            switch result {
            case .success(let data):
                
                cell.margaritasImage.image = UIImage(data: data)
            case .failure(let error):
                print(error)
            }
        }
        return cell
    }
}

// MARK: - Navigation
extension MargaritaViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let detailVC = segue.destination as? MargaritasDetailViewController else { return }
        guard let indexPath = margaritasTableView.indexPathForSelectedRow else { return }
        guard let cell = margaritasTableView.cellForRow(at: indexPath) as? MargaritaViewCell else { return }
        
        detailVC.margarita = margaritas[indexPath.row]
        detailVC.margaritasImage = cell.margaritasImage.image
        
    }
}


// MARK: - Loading Screen
extension MargaritaViewController {
    private func removeLoadingScreen() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        loadingView.isHidden = true
        loadingLabel.isHidden = true
    }
}
