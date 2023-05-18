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

struct Current: Codable {
    let temp_f: Float
}

struct Weather: Codable {
    let location: Location
    let current: Current
}
