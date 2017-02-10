//
//  MasterViewController.swift
//  Marvel Heroes
//
//  Created by Danilo Maia Rodrigues on 10/02/17.
//  Copyright © 2017 Danilo Maia Rodrigues. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    var heroes = [Hero]()
    
    let heroesProvider = HeroesProvider()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assim que a view é carregada, uma requisição assíncrona é feita para popular a TableView
        heroesProvider.listHeroesWith(offset: 0) { (heroesData) in
            
            //Quando a resposta é recebida, recarrega a tabela com os novos dados
            self.updateTableWith(heroes: heroesData)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Concatena o novo vetor de personagens ao já existente e recarrega a tabela
    func updateTableWith(heroes: [Hero]?) {
        if let unwrappedHeroes = heroes {
            self.heroes+=unwrappedHeroes;
            self.tableView.reloadData()
        }
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let hero = heroes[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                //Manda o Hero como clicado como parâmetro para a próxima controladora
                controller.detailItem = hero
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    //Há somente uma seção
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //O número de elementos na tabela é o número de elementos no array de Hero
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }

    //Renderiza as células somente com o nome do personagens
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let hero = heroes[indexPath.row]
        cell.textLabel!.text = hero.name
        return cell
    }

    //Desabilita a função de editar célular
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    //Ao soltar o scroll no final da tabela, manda uma nova requisição solicitando mais personagens
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let actualPosition: CGFloat = scrollView.contentOffset.y;
        let contentHeight: CGFloat = scrollView.contentSize.height - (tableView.frame.size.height);
        if (actualPosition >= contentHeight) {
            heroesProvider.listHeroesWith(offset: self.heroes.count) { (heroesData) in
                self.updateTableWith(heroes: heroesData)
            }
        }
    }


}

