//
//  DetailViewController.swift
//  Marvel Heroes
//
//  Created by Danilo Maia Rodrigues on 10/02/17.
//  Copyright © 2017 Danilo Maia Rodrigues. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //Outlets para os elementos de interface
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    
    var detailItem: Hero? {
        didSet {
            // Recarrega a view.
            self.configureView()
        }
    }

    func configureView() {
        //Checa todos os Optionals
        guard let hero = self.detailItem, let label = self.detailDescriptionLabel, let name = hero.name else {
            return
        }
        
        //Define o titulo da controladora
        self.navigationItem.title = name
        
        //Carrega a imagem a partir da url, se existir
        if let thumbnail = hero.thumbnail {
            let link = thumbnail.url()
            thumbnailImageView.downloadedFrom(link: link)
        }
        
        //Carrega a descrição do personagem, se existir
        if let description = hero.description {
            //Como a descrição do personagem pode vir vazia, existe mais uma validação a ser feita
            if (description != "") {
                label.text = description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

