//
//  MargaritasDetailViewController.swift
//  CoctailRecepiesAF
//
//  Created by Nikolai Maksimov on 06.07.2022.
//

import UIKit

class MargaritasDetailViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var margaritasImageView: UIImageView!
    
    @IBOutlet var margaritasNameLabel: UILabel!
    
    @IBOutlet var margaritasInstructionLabel: UILabel!
    
    // MARK: - Public Properties
    var margarita: Margarita!
    var margaritasImage: UIImage!
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
    }
    
    // MARK: - Private Methods
    private func updateUI() {
        margaritasImageView.layer.cornerRadius = 30
        margaritasImageView.image = margaritasImage
        margaritasNameLabel.text = margarita.strDrink
        margaritasInstructionLabel.text = margarita.strInstructions
    }
}
