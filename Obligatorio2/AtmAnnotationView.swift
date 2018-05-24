import UIKit
import Alamofire
import AlamofireObjectMapper
import MapKit
import UIKit


class AtmAnnotationView : MKPointAnnotation {
    var colour: UIColor?
    var atmId : Int?
    override init() {
        self.colour = UIColor.white
    }
}
