//
//  CocktailViewController.swift
//  togtail
//
//  Created by Tolga Yakar on 24.01.2024.
//

import UIKit

class DrinksViewController: UIViewController{
    
    var letter: String?
    let networkManager = NetworkModel()
    private var _drinksModel: DrinksModel?
    
    var selectedItemIndex : Int?
    
    @IBOutlet weak var drinksCollectionView: UICollectionView!
    @IBOutlet weak var drinksView: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Setting DrinksViewController dataSource and delegate for drinkCollectionView.
        /*
            DrinksViewController should adopt UICollectionViewDataSource and UICollectionViewDelegate
         protocols in order to perform creating cell operations, selection operations etc.
            Because it becomes subclass of UICollectionViewDataSource and UICollectionViewDelegate, dataSource and delegate protocols assign to self.
         */
        drinksCollectionView.dataSource = self
        drinksCollectionView.delegate = self
        
        GradientBackground.initGradientBG(view: drinksView)
        
        // Do any additional setup after loading the view.
        //Performing network session in order to get drink datas from TheCocktailDB API.
        GetDrinkData()
    }
}

//MARK: Collection View Data Source Operations
extension DrinksViewController: UICollectionViewDataSource {

    //Getting the number of
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _drinksModel?.drinks.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let drinkCell = collectionView.dequeueReusableCell(withReuseIdentifier: "drinkCell", for: indexPath) as! DrinksCollectionViewCell
        
        drinkCell.drinksNameLabel.text = _drinksModel?.drinks[indexPath.row].strDrink
        
        let imageUrl = _drinksModel?.drinks[indexPath.row].strDrinkThumb
        
        GetImage(imageUrl: imageUrl) { (image: UIImage?) in
            if let image = image {
                drinkCell.drinksImageView.image = image
            }
        }
        
        return drinkCell
    }
}

//MARK: Collection View Delegate Operations
extension DrinksViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItemIndex = indexPath.row
        performSegue(withIdentifier: "recipeSegue", sender: self)
    }
}

//MARK: DrinksViewController methods
extension DrinksViewController {
    
    private func GetDrinkData() {
        
        //Thanks to TheCocktailDB API, drinks data can be fetched via using networkManagers fetchData method.
        self.networkManager.fetchData(byLetter: self.letter!.lowercased()) { (result: DrinksModel?) in
            if let result = result {
                DispatchQueue.main.async{
                    self._drinksModel = result
                    
                    //Reloads collection view after fetching parsed JSON data as drinks model.
                    self.drinksCollectionView.reloadData()
                }
            }
        }
    }
    
    private func GetImage(imageUrl: String?, completion: @escaping (UIImage?) -> Void) {
        
        if let imageUrl = URL(string: imageUrl!) {
            
            let imageSession = URLSession(configuration: .default)
            
            let imageTask = imageSession.dataTask(with: imageUrl) { (data, response, error) in
                if let imageData = data {
                    DispatchQueue.main.async {
                        completion(UIImage(data: imageData))
                    }
                }
            }
            
            imageTask.resume()
        }
    }
}


//MARK: Prepare for segue

extension DrinksViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "recipeSegue" {
            
            let dest = segue.destination as! RecipeViewController
            
            dest.ingredients = (_drinksModel?.drinks[selectedItemIndex!].ingredients)!
            dest.recipe = (_drinksModel?.drinks[selectedItemIndex!].strInstructions)!
        }
    }
}
