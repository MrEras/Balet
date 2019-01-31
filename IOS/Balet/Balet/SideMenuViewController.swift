import UIKit

class SideMenuViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {return .lightContent}
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray.withAlphaComponent(0.45)
        self.showAnimate()
    }
    
    @IBAction func hideMenu(_ sender: Any) {removeAnimate()}
}
