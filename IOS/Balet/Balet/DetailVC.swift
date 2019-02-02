import UIKit
import MapKit

class DetailVC: UIViewController {
    @IBOutlet var nameLab: UILabel!
    @IBOutlet var imgV: UIImageView!
    @IBOutlet var descLab: UILabel!
    var parking : Parking?
    override var preferredStatusBarStyle: UIStatusBarStyle {return .lightContent}
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        self.showAnimate()
        self.configure(self.parking!)
    }
    @IBAction func close(_ sender: Any) {removeAnimate()}
    @IBAction func openInMaps(_ sender: Any) {
        let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: (self.parking?.lat)! , longitude: (self.parking?.long)!), addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeTransit]
        mapItem.openInMaps(launchOptions: launchOptions)
    }
}
extension DetailVC {
    func configure(_ park: Parking){
        imgV.downloadedFrom(link: park.URLImg!)
        nameLab.text = " " + park.name!
        descLab.text = park.description! + "\nPrecio: $\(park.price)\nLugares disponibles: \(park.disp)"
    }
}
