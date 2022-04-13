//
//  GeocacheAttributes.swift
//  Woods
//
//  Created by Fredrik on 3/3/21.
//  Copyright © 2021 Fredrik.
//

struct GeocacheAttributes: OptionSet, Codable, Hashable {
    let rawValue: UInt64
    
    // Permissions
    static let dogs = GeocacheAttributes(rawValue: 1 << 0)
    static let bicycles = GeocacheAttributes(rawValue: 1 << 1)
    static let motorcycles = GeocacheAttributes(rawValue: 1 << 2)
    static let quads = GeocacheAttributes(rawValue: 1 << 3)
    static let offRoadVehicles = GeocacheAttributes(rawValue: 1 << 4)
    static let snowmobiles = GeocacheAttributes(rawValue: 1 << 5)
    static let horses = GeocacheAttributes(rawValue: 1 << 6)
    static let campfires = GeocacheAttributes(rawValue: 1 << 7)
    static let truckDriverRV = GeocacheAttributes(rawValue: 1 << 8)
    
    // Facilities
    static let wheelchairAvailable = GeocacheAttributes(rawValue: 1 << 9)
    static let parkingAvailable = GeocacheAttributes(rawValue: 1 << 10)
    static let publicTransportation = GeocacheAttributes(rawValue: 1 << 11)
    static let drinkingWaterNearby = GeocacheAttributes(rawValue: 1 << 12)
    static let publicRestroomsNearby = GeocacheAttributes(rawValue: 1 << 13)
    static let telephoneNearby = GeocacheAttributes(rawValue: 1 << 14)
    static let picnicTablesNearby = GeocacheAttributes(rawValue: 1 << 15)
    static let campingAvailable = GeocacheAttributes(rawValue: 1 << 16)
    static let strollerAvailable = GeocacheAttributes(rawValue: 1 << 17)
    static let fuelNearby = GeocacheAttributes(rawValue: 1 << 18)
    static let foodNearby = GeocacheAttributes(rawValue: 1 << 19)
    
    // Equipment
    static let accessOrParkingFee = GeocacheAttributes(rawValue: 1 << 20)
    static let climbingGear = GeocacheAttributes(rawValue: 1 << 21)
    static let boat = GeocacheAttributes(rawValue: 1 << 22)
    static let scubaGear = GeocacheAttributes(rawValue: 1 << 23)
    static let flashlightRequired = GeocacheAttributes(rawValue: 1 << 24)
    static let uvLightRequired = GeocacheAttributes(rawValue: 1 << 25)
    static let snowshoes = GeocacheAttributes(rawValue: 1 << 26)
    static let crossCountrySkis = GeocacheAttributes(rawValue: 1 << 27)
    static let specialToolRequired = GeocacheAttributes(rawValue: 1 << 28)
    static let wirelessBeacon = GeocacheAttributes(rawValue: 1 << 29)
    static let treeClimbing = GeocacheAttributes(rawValue: 1 << 30)
    
    // Hazards
    static let poisonousPlants = GeocacheAttributes(rawValue: 1 << 31)
    static let dangerousAnimals = GeocacheAttributes(rawValue: 1 << 32)
    static let ticks = GeocacheAttributes(rawValue: 1 << 33)
    static let abandonedMines = GeocacheAttributes(rawValue: 1 << 34)
    static let cliffFallingRocks = GeocacheAttributes(rawValue: 1 << 35)
    static let hunting = GeocacheAttributes(rawValue: 1 << 36)
    static let dangerousArea = GeocacheAttributes(rawValue: 1 << 37)
    static let thorns = GeocacheAttributes(rawValue: 1 << 38)
    
    // Conditions
    static let recommendedForKids = GeocacheAttributes(rawValue: 1 << 39)
    static let takesLessThanAnHour = GeocacheAttributes(rawValue: 1 << 40)
    static let scenicView = GeocacheAttributes(rawValue: 1 << 41)
    static let significantHike = GeocacheAttributes(rawValue: 1 << 42)
    static let difficultClimbing = GeocacheAttributes(rawValue: 1 << 43)
    static let mayRequireWading = GeocacheAttributes(rawValue: 1 << 44)
    static let mayRequireSwimming = GeocacheAttributes(rawValue: 1 << 45)
    static let availableAtAllTimes = GeocacheAttributes(rawValue: 1 << 46)
    static let recommendedAtNight = GeocacheAttributes(rawValue: 1 << 47)
    static let availableDuringWinter = GeocacheAttributes(rawValue: 1 << 48)
    static let stealthRequired = GeocacheAttributes(rawValue: 1 << 49)
    static let needsMaintenance = GeocacheAttributes(rawValue: 1 << 50)
    static let watchForLivestock = GeocacheAttributes(rawValue: 1 << 51)
    static let fieldPuzzle = GeocacheAttributes(rawValue: 1 << 52)
    static let nightCache = GeocacheAttributes(rawValue: 1 << 53)
    static let parkAndGrab = GeocacheAttributes(rawValue: 1 << 54)
    static let abandonedStructure = GeocacheAttributes(rawValue: 1 << 55)
    static let shortHike = GeocacheAttributes(rawValue: 1 << 56) // < 1km
    static let mediumHike = GeocacheAttributes(rawValue: 1 << 57) // 1km - 10km
    static let longHike = GeocacheAttributes(rawValue: 1 << 58) // > 10km
    static let seasonalAccess = GeocacheAttributes(rawValue: 1 << 59)
    static let touristFriendly = GeocacheAttributes(rawValue: 1 << 60)
    static let frontYardPrivateResidence = GeocacheAttributes(rawValue: 1 << 61)
    static let teamworkRequired = GeocacheAttributes(rawValue: 1 << 62)
}
