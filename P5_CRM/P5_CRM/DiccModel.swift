//
//  DiccModel.swift
//  P5_CRM
//
//  Created by Sofia Vidal Urriza on 25/11/2017.
//  Copyright © 2017 Sofia Vidal Urriza. All rights reserved.
//

import Foundation

// Creamos strucks con codable para facilitar la labor de los diccionarios
struct Visit: Codable {
    
    let plannedFor: String
    let CustomerId: Int
    let SalesmanId: Int
    let favourite: Bool
    let Customer: Customer
    let Salesman: Salesman
    
}
struct Customer: Codable {
    let id: Int
    let name: String
    let cif: String
    let address1: String
    let address2: String
    let postalCode: String
    let phone1: String
    let email1: String
    let web: String
    
}

struct Salesman : Codable {
    let id: Int
    let login: String
    let fullname: String
    let isAdmin: Bool
    let isSalesman: Bool
    let phone1: String?
    let phone2: String?
    let email1: String?
    let email2: String?
    let notes: String?
    let PhotoId: Int?
    let Photo: Photo?
}

struct Photo: Codable {
    let id: Int
    let url: String
    let mime: String
}
