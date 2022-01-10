//
//  ViewController.swift
//  ProblemInMyCity
//
//  Created by Henry Bilby on 08/01/22.
//

import UIKit
import CoreData

class ListaProblemasViewController: UIViewController {

    var fetchedResultController : NSFetchedResultsController<Problem>!
    
    @IBOutlet weak var tableViewProblemas: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewProblemas.dataSource = self
        tableViewProblemas.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadProblems()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "vaiParaDetalhe" {
            guard let controller = segue.destination as? DetalhaProblemaViewController else {return}
            controller.problem = sender as? Problem
        }
    }

    @IBAction func criarProblema(_ sender: Any) {
        performSegue(withIdentifier: "vaiParaCriacaoEdicao", sender: nil)
    }
    
    private func loadProblems() {
        let fetchRequest : NSFetchRequest<Problem> = Problem.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "nome", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultController.delegate = self
        try? fetchedResultController.performFetch()
    }
}

extension ListaProblemasViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "problemaItem", for: indexPath) as? ProblemaTableViewCell{
            cell.setup(problem: fetchedResultController.object(at: indexPath))
            return cell
        }
        return UITableViewCell()
    }
}

extension ListaProblemasViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "vaiParaDetalhe", sender:fetchedResultController.object(at: indexPath))
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(fetchedResultController.object(at: indexPath))
            try? context.save()
        }
    }
}

extension ListaProblemasViewController : NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        tableViewProblemas.reloadData()
    }
}
