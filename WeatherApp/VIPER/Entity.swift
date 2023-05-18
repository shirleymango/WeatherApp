//
//  Entity.swift
//  WeatherApp
//
//  Created by ZhuMacPro on 5/17/23.
//

import Foundation

struct Location: Codable {
    let name: String
}

struct Weather: Codable {
    let location: Location
}
