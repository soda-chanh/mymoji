//  Copyright © 2017 Stacey Dao. All rights reserved.

import UIKit
import Messages

enum Category {
    case happy
    case disgruntled
}

protocol CategoryViewControllerDelegate: class {
    func emotionViewController(_: CategoryViewController, didSelect category: Category)
}

class CategoryViewController: UICollectionViewController {

    enum Constants {
        static let storyboardIdentifier = "EmotionViewController"
    }

    var delegate: CategoryViewControllerDelegate?
    var categoryList = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        categoryList.append(.happy)
        categoryList.append(.disgruntled)
        collectionView?.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoryList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MymojiCell.Constants.reuseIdentifier, for: indexPath) as? MymojiCell else { return UICollectionViewCell() }
        if indexPath.row == 0 {
            cell.imageView.image = UIImage(named:"happy")
        } else {
            cell.imageView.image = UIImage(named:"unhappy")
        }
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = self.categoryList[indexPath.row]
        delegate?.emotionViewController(self, didSelect: category)
    }
}
