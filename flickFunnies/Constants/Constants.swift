//
//  Colors.swift
//  flickFunnies
//
//  Created by Batista Tone on 19/05/23.
//

import Foundation

var API_URL = "http://localhost:3001/api/"


class Constants {
    static let colors = Colors()
}


struct Colors {
    let background =  hexStringToUIColor(hex: "#04151F")
    let button = hexStringToUIColor(hex: "#183A37")
    let text  = hexStringToUIColor(hex: "#FFFDF7")
    let text1 = hexStringToUIColor(hex: "#E8E9EB")
    let avatar  = hexStringToUIColor(hex: "#C44900")
    let loveButton = hexStringToUIColor(hex: "#EF6461")
}
