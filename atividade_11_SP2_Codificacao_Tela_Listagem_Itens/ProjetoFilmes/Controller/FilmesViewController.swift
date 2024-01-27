//
//  FilmesViewController.swift
//  ProjetoFilmes
//
//  Created by Marcos on 27/01/24.
//

// import Foundation

import UIKit
import CoreData

class FilmesTableViewController: UITableViewController{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var filmes: [Filmes] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchFilmesData()
        criarFilmesDeTeste()
    }
    
    func configureTableView(){
        tableView.rowHeight = 100
    }
    
    func fetchFilmesData(){
        do{
            filmes = try context.fetch(Filmes.fetchRequest())
            tableView.reloadData()
        }catch{
            AlertHelper.showAlert(on: self, titulo: "Erro", mensagem: "Erro ao buscar Filmes")
        }
    }
    
    func criarFilmesDeTeste(){
        
        let filme1 = Filmes(context: context)
        filme1.titulo = "Filme de Teste 1"
        filme1.diretor = "Diretor 1"
        
        
        do{
            try context.save()
            tableView.reloadData()
        }catch{
            AlertHelper.showAlert(on: self, titulo: "Erro", mensagem: "Erro ao criar Filmes")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return filmes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmesTableViewCell", for: indexPath) as! FilmesTableViewCell
        let filme = filmes[indexPath.row]
        
        cell.tituloLabel.text = filme.titulo ?? "Titulo desconhecido"
        cell.diretorLabel.text = filme.diretor ?? "Diretor desconhecido"
        cell.generoLabel.text = filme.genero ?? "Genero desconhecido"
        
        if let capaData = filme.capa, let capaImage = UIImage(data: capaData){
            cell.capaImageView.image = capaImage
        }else{
            cell.capaImageView.image = UIImage(named: "movie")
        }
        return cell
        
        
    }
    
}
