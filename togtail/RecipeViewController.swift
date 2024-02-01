//
//  RecipeViewController.swift
//  togtail
//
//  Created by Tolga Yakar on 29.01.2024.
//

import UIKit

class RecipeViewController: UIViewController {

    @IBOutlet weak var recipeView: UIView!
    @IBOutlet weak var recipeTableCell: UITableView!
    @IBOutlet weak var recipeLabel: UILabel!
    
    //The ingredients and recipe datas taken from the previous page.
    var ingredients : [String?] = []
    var recipe : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Setting gradient backgroun for this view.
        GradientBackground.initGradientBG(view: recipeView)

        recipeTableCell.dataSource = self
        recipeLabel.text = recipe
    }
}

extension RecipeViewController: UITableViewDataSource {
    
    //Geting number of rows in selection data for table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    //Creating table cells and populating cells with ingredients.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as! TableViewCell
        
        cell.ingredientCellLabel.text = ingredients[indexPath.row]
        
        return cell
    }
}
