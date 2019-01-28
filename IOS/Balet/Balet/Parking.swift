import Foundation
import UIKit

class Parking{
    var URLImg: String?
    var name: String?
    var description: String?
    var disp: Int = 0
    
    init(webURL inURL: String, name inName: String, desc inDesc: String,_ dispo:Int? = 0) {
        self.URLImg = inURL
        self.name = inName
        self.description = inDesc
        self.disp = dispo!
    }
}

class ParkingCell : UITableViewCell{
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var nameLab: UILabel!
    @IBOutlet var descLab: UILabel!
    @IBOutlet var dispLab: UILabel!
    
    override func awakeFromNib() {super.awakeFromNib()}
    
    func configureCell(_ park: Parking){
        imgView.downloadedFrom(link: park.URLImg!)
        nameLab.text = park.name! // "Nombre Est: " + 
        descLab.text = "Descripción: " + park.description!
        dispLab.text = "Hay \(park.disp) lugares disponibles"
    }
}
