//
//  ViewController.swift
//  togtail
//
//  Created by Tolga Yakar on 22.01.2024.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var gradientView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedLetter: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        GradientBackground.initGradientBG(view: gradientView)
        
        /*
         Setting dataSource as ViewController because
         dataSource prop is a type of UICollectionViewDataSource and
         our ViewController class needs to adopt UICollectionViewDataSource.
         So it becomes a UICollectionViewDataSource.
        */
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //When a custon cell is going to be used, it needs to be registered at collectionView
        //Because it is a xib (which is old name for nib folder), it is registered with UINib with nibName.
        collectionView.register(UINib(nibName: "LetterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    //Because ViewController is set to dataSource itself, it needs to adopt UICollectionDataSource protocol.
    //One of the methods that ViewController needs to implement is collectionView method with numberOfItemsInSection paramter.
    //This function returns the number of the data for the collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AlphabetLetters.alphabetLetters.count
    }
    
    //This method is another method that ViewController must adopt.
    //Dequeueing of cells happens within this scope.
    //Returns cells.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LetterCollectionViewCell
        
        //Changing the label text based on the indexPath (The corresponding index number of the cell in alphabetLetters).
        cell.cellLabel.text = AlphabetLetters.alphabetLetters[indexPath.row]
        
        return cell
    }
    
    //To determine whether collection view cell should be selected or not.
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Tells the delegate that the item at the specified index path was selected.
    //If selection of a cell is successful, this method is called.
    //Because selection is successful, segue can be performed within this scope.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedLetter = AlphabetLetters.alphabetLetters[indexPath.row]
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let destination = segue.destination as! DrinksViewController
            destination.letter = selectedLetter
        }
    }
}

