//
//  AtmDetailViewController.swift
//  Obligatorio2
//
//  Created by Ricardo Umpierrez on 5/19/18.
//  Copyright © 2018 Ricardo Umpierrez. All rights reserved.
//

import UIKit

class AtmDetailViewController: UIViewController {
    
    var atm:Atm!;
    
    @IBOutlet weak var networkImage: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var openTime: UITextField!
    @IBOutlet weak var availableMoney: UITextField!
    @IBOutlet weak var textContainers: UIView!
    @IBOutlet weak var noDeposits: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImageLoad.setImageView(url: URL(string: atm.imageUrl!)!, view: self.view)
        ImageLoad.downloadImage(url: URL(string: ImageLoad.decideNetworkImage(network: atm.network!))!, image: networkImage)
        self.putRoundBorderButton()
        self.putGradient()
        self.address.text = atm.address;
        self.openTime.text = atm.openHours;
        self.availableMoney.text = atm.hasMoney! ? "Has Money" : "No has Money";
        self.noDeposits.text = atm.acceptsDeposits! ? "Accept Deposit" : "No Accept Deposit";    }
    
    func putRoundBorderButton() {
        closeButton.backgroundColor = .white
        closeButton.layer.cornerRadius = 20
        closeButton.layer.borderWidth = 1
        closeButton.layer.borderColor = UIColor.black.cgColor
    }
    
    func putGradient(){ let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.view.frame
        gradient.colors = [ UIColor.clear.cgColor, UIColor.white.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.8)
        self.view.layer.insertSublayer(gradient, at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning().
    }
    

}
