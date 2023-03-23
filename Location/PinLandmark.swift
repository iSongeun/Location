//
//  PinLandmark.swift
//  Location
//
//  Created by 이송은 on 2023/03/23.
//

import Foundation

import Foundation
import MapKit
enum PinLandmark : Int, CaseIterable{
    case Deok_su_gung = 100
    case Gyeong_bok_gung = 200
    case Si_cheong = 300
}

extension PinLandmark{
    var title : String {
        return "\(self)"
    }
    
    var id : Int {
        self.rawValue
    }
    
    var coordinate : CLLocationCoordinate2D {
        switch self {
        case .Deok_su_gung :
            return .init(latitude: 37.5658049, longitude: 126.9751461)
        case .Gyeong_bok_gung :
            return .init(latitude: 37.5785635, longitude: 126.9769535)
        case .Si_cheong :
            return .init(latitude: 37.5662952, longitude: 126.9779451)
        }
    }
    
    var url : URL? {
        switch self {
        case .Deok_su_gung :
            return .init(string: "https://www.deoksugung.go.kr/")
        case .Gyeong_bok_gung :
            return .init(string: "https://www.royalpalace.go.kr/")
        case .Si_cheong :
            return .init(string: "https://www.seoul.go.kr/main/index.jsp")
        }
    }
}

