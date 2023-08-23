//
//  GameViewController.swift
//  CatchTheGhost
//
//  Created by Harsh Vardhan Kushwaha on 23/08/23.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
   
    @IBOutlet weak var changePositionsButton: UIButton!
    
    var gameData: GameData!
    var randomData: RandomData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "GridCell", bundle: .main), forCellWithReuseIdentifier: "GridCell")
        setupData()
    }
    
    func setupData() {
        randomise()
        self.randomData.isFirstLoad = true
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    @IBAction func changePositionsTapped(_ sender: UIButton) {
        randomise()
        collectionView.reloadData()
        sender.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            sender.isUserInteractionEnabled = true
        }
    }
    
    func randomise(){
        let policeRow = Int.random(in: 0...(gameData.row - 1))
        let policeColumn = Int.random(in: 0...(gameData.column - 1))
        let ghostRow = (0...(gameData.row - 1)).random(without: [policeRow])
        let ghostColumn = (0...(gameData.column - 1)).random(without: [policeColumn])
        self.randomData = RandomData(policeRow: policeRow, policeColumn: policeColumn, ghostRow: ghostRow, ghostColumn: ghostColumn)
    }
}


extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as! GridCell
        let character = self.randomData.getCharacterWithIndexPath(indexPath: indexPath)
        cell.setupImage(character: character,isReload: self.randomData.isFirstLoad)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return gameData.row
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameData.column
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 10)/CGFloat(gameData.column), height: (collectionView.frame.height - 10)/CGFloat(gameData.row))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .zero
    }
}



struct GameData {
    var row:Int
    var column:Int
}

struct RandomData {
    var policeRow:Int
    var policeColumn:Int
    var ghostRow:Int
    var ghostColumn:Int
    var isFirstLoad:Bool = false
    
    func getCharacterWithIndexPath(indexPath: IndexPath) ->  Character{
        if policeRow == indexPath.section, policeColumn == indexPath.item {
            return .police
        }else if ghostRow == indexPath.section, ghostColumn == indexPath.item {
            return .ghost
        }
        return .none
    }
}

extension ClosedRange where Element: Hashable {
    func random(without excluded:[Element]) -> Element {
        let valid = Set(self).subtracting(Set(excluded))
        let random = Int(arc4random_uniform(UInt32(valid.count)))
        return Array(valid)[random]
    }
}
