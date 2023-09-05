//
//  File.swift
//  
//
//  Created by Pedro Rojas on 31/08/23.
//

import Foundation
import Fakery
import BonMot
import UIColorHexSwift
import SwiftUI

public struct Demo {
    public static func getName() -> String {
        Faker().name.name() // It is not working ❌
        //"\"\(StringStyle().attributes.description)\"" // It works ✅
        //#""Hello""# // It works ✅
        
        //"#FFFFFF".argb2rgba! // It is not working ❌
    }
}
