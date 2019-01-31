import UIKit

class LogVC: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {return .lightContent}
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
