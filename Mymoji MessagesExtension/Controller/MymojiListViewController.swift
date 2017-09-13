//  Copyright © 2017 Stacey Dao. All rights reserved.

import UIKit
import CoreGraphics
import Messages

class MymojiListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    enum Constants {
        static let storyboardIdentifier = "MymojiViewController"
    }

    @IBOutlet private weak var collectionView: UICollectionView!
    var delegate: MymojiViewControllerDelegate?
    var category: Category = .happy
    var happyMymoji: [Mymoji] = []
    var unhappyMymoji: [Mymoji] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        happyMymoji = [Mymoji(image: UIImage(named: "happy1")!),
                       Mymoji(image: UIImage(named: "happy2")!),
                       Mymoji(image: UIImage(named: "happy3")!),
                       Mymoji(image: UIImage(named: "happy4")!),
                       Mymoji(image: UIImage(named: "happy5")!),
                       Mymoji(image: UIImage(named: "happy6")!),
                       Mymoji(image: UIImage(named: "happy7")!)]
        unhappyMymoji = [Mymoji(image: UIImage(named: "unhappy1")!),
                         Mymoji(image: UIImage(named: "unhappy2")!),
                         Mymoji(image: UIImage(named: "unhappy3")!),
                         Mymoji(image: UIImage(named: "unhappy4")!),
                         Mymoji(image: UIImage(named: "unhappy5")!)]
    }

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category == .happy ? happyMymoji.count : unhappyMymoji.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MymojiCell.Constants.reuseIdentifier, for: indexPath) as? MymojiCell else { fatalError("CollectionView failed to dequeue EmotionCell") }
        let mymojiList: [Mymoji] = category == .happy ? happyMymoji : unhappyMymoji
        let mymoji = mymojiList[indexPath.row]
        cell.imageView.image = mymoji.image
        return cell
    }

    // MARK: UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mymojiList: [Mymoji] = category == .happy ? happyMymoji : unhappyMymoji
        let mymoji = mymojiList[indexPath.row]
        delegate?.send(mymoji: mymoji)
    }
}

extension MymojiListViewController {
    func createLayoutImage() -> UIImage? {
        let size = CGSize(width:self.view.bounds.width, height: self.view.bounds.height)
        UIGraphicsBeginImageContextWithOptions(size, true, 1.0)
        self.view.drawHierarchy(in: self.view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension MymojiListViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

protocol MymojiViewControllerDelegate: class {
    func send(mymoji: Mymoji)
}
