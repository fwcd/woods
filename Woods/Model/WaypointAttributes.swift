//
//  WaypointAttributes.swift
//  Woods
//
//  Created by Fredrik on 3/3/21.
//  Copyright © 2021 Fredrik.
//

struct WaypointAttributes: OptionSet, Codable, Hashable {
    let rawValue: UInt64
    
    // Permissions
    static let dogs = Self(rawValue: 1 << 0)
    static let bicycles = Self(rawValue: 1 << 1)
    static let motorcycles = Self(rawValue: 1 << 2)
    static let quads = Self(rawValue: 1 << 3)
    static let offRoadVehicles = Self(rawValue: 1 << 4)
    static let snowmobiles = Self(rawValue: 1 << 5)
    static let horses = Self(rawValue: 1 << 6)
    static let campfires = Self(rawValue: 1 << 7)
    static let truckDriverRV = Self(rawValue: 1 << 8)
    
    // Facilities
    static let wheelchairAvailable = Self(rawValue: 1 << 9)
    static let parkingAvailable = Self(rawValue: 1 << 10)
    static let publicTransportation = Self(rawValue: 1 << 11)
    static let drinkingWaterNearby = Self(rawValue: 1 << 12)
    static let publicRestroomsNearby = Self(rawValue: 1 << 13)
    static let telephoneNearby = Self(rawValue: 1 << 14)
    static let picnicTablesNearby = Self(rawValue: 1 << 15)
    static let campingAvailable = Self(rawValue: 1 << 16)
    static let strollerAvailable = Self(rawValue: 1 << 17)
    static let fuelNearby = Self(rawValue: 1 << 18)
    static let foodNearby = Self(rawValue: 1 << 19)
    
    // Equipment
    static let accessOrParkingFee = Self(rawValue: 1 << 20)
    static let climbingGear = Self(rawValue: 1 << 21)
    static let boat = Self(rawValue: 1 << 22)
    static let scubaGear = Self(rawValue: 1 << 23)
    static let flashlightRequired = Self(rawValue: 1 << 24)
    static let uvLightRequired = Self(rawValue: 1 << 25)
    static let snowshoes = Self(rawValue: 1 << 26)
    static let crossCountrySkis = Self(rawValue: 1 << 27)
    static let specialToolRequired = Self(rawValue: 1 << 28)
    static let wirelessBeacon = Self(rawValue: 1 << 29)
    static let treeClimbing = Self(rawValue: 1 << 30)
    
    // Hazards
    static let poisonousPlants = Self(rawValue: 1 << 31)
    static let dangerousAnimals = Self(rawValue: 1 << 32)
    static let ticks = Self(rawValue: 1 << 33)
    static let abandonedMines = Self(rawValue: 1 << 34)
    static let cliffFallingRocks = Self(rawValue: 1 << 35)
    static let hunting = Self(rawValue: 1 << 36)
    static let dangerousArea = Self(rawValue: 1 << 37)
    static let thorns = Self(rawValue: 1 << 38)
    
    // Conditions
    static let recommendedForKids = Self(rawValue: 1 << 39)
    static let takesLessThanAnHour = Self(rawValue: 1 << 40)
    static let scenicView = Self(rawValue: 1 << 41)
    static let significantHike = Self(rawValue: 1 << 42)
    static let difficultClimbing = Self(rawValue: 1 << 43)
    static let mayRequireWading = Self(rawValue: 1 << 44)
    static let mayRequireSwimming = Self(rawValue: 1 << 45)
    static let availableAtAllTimes = Self(rawValue: 1 << 46)
    static let recommendedAtNight = Self(rawValue: 1 << 47)
    static let availableDuringWinter = Self(rawValue: 1 << 48)
    static let stealthRequired = Self(rawValue: 1 << 49)
    static let needsMaintenance = Self(rawValue: 1 << 50)
    static let watchForLivestock = Self(rawValue: 1 << 51)
    static let fieldPuzzle = Self(rawValue: 1 << 52)
    static let nightCache = Self(rawValue: 1 << 53)
    static let parkAndGrab = Self(rawValue: 1 << 54)
    static let abandonedStructure = Self(rawValue: 1 << 55)
    static let shortHike = Self(rawValue: 1 << 56) // < 1km
    static let mediumHike = Self(rawValue: 1 << 57) // 1km - 10km
    static let longHike = Self(rawValue: 1 << 58) // > 10km
    static let seasonalAccess = Self(rawValue: 1 << 59)
    static let touristFriendly = Self(rawValue: 1 << 60)
    static let frontYardPrivateResidence = Self(rawValue: 1 << 61)
    static let teamworkRequired = Self(rawValue: 1 << 62)
}
