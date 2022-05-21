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
    static let dogs = WaypointAttributes(rawValue: 1 << 0)
    static let bicycles = WaypointAttributes(rawValue: 1 << 1)
    static let motorcycles = WaypointAttributes(rawValue: 1 << 2)
    static let quads = WaypointAttributes(rawValue: 1 << 3)
    static let offRoadVehicles = WaypointAttributes(rawValue: 1 << 4)
    static let snowmobiles = WaypointAttributes(rawValue: 1 << 5)
    static let horses = WaypointAttributes(rawValue: 1 << 6)
    static let campfires = WaypointAttributes(rawValue: 1 << 7)
    static let truckDriverRV = WaypointAttributes(rawValue: 1 << 8)
    
    // Facilities
    static let wheelchairAvailable = WaypointAttributes(rawValue: 1 << 9)
    static let parkingAvailable = WaypointAttributes(rawValue: 1 << 10)
    static let publicTransportation = WaypointAttributes(rawValue: 1 << 11)
    static let drinkingWaterNearby = WaypointAttributes(rawValue: 1 << 12)
    static let publicRestroomsNearby = WaypointAttributes(rawValue: 1 << 13)
    static let telephoneNearby = WaypointAttributes(rawValue: 1 << 14)
    static let picnicTablesNearby = WaypointAttributes(rawValue: 1 << 15)
    static let campingAvailable = WaypointAttributes(rawValue: 1 << 16)
    static let strollerAvailable = WaypointAttributes(rawValue: 1 << 17)
    static let fuelNearby = WaypointAttributes(rawValue: 1 << 18)
    static let foodNearby = WaypointAttributes(rawValue: 1 << 19)
    
    // Equipment
    static let accessOrParkingFee = WaypointAttributes(rawValue: 1 << 20)
    static let climbingGear = WaypointAttributes(rawValue: 1 << 21)
    static let boat = WaypointAttributes(rawValue: 1 << 22)
    static let scubaGear = WaypointAttributes(rawValue: 1 << 23)
    static let flashlightRequired = WaypointAttributes(rawValue: 1 << 24)
    static let uvLightRequired = WaypointAttributes(rawValue: 1 << 25)
    static let snowshoes = WaypointAttributes(rawValue: 1 << 26)
    static let crossCountrySkis = WaypointAttributes(rawValue: 1 << 27)
    static let specialToolRequired = WaypointAttributes(rawValue: 1 << 28)
    static let wirelessBeacon = WaypointAttributes(rawValue: 1 << 29)
    static let treeClimbing = WaypointAttributes(rawValue: 1 << 30)
    
    // Hazards
    static let poisonousPlants = WaypointAttributes(rawValue: 1 << 31)
    static let dangerousAnimals = WaypointAttributes(rawValue: 1 << 32)
    static let ticks = WaypointAttributes(rawValue: 1 << 33)
    static let abandonedMines = WaypointAttributes(rawValue: 1 << 34)
    static let cliffFallingRocks = WaypointAttributes(rawValue: 1 << 35)
    static let hunting = WaypointAttributes(rawValue: 1 << 36)
    static let dangerousArea = WaypointAttributes(rawValue: 1 << 37)
    static let thorns = WaypointAttributes(rawValue: 1 << 38)
    
    // Conditions
    static let recommendedForKids = WaypointAttributes(rawValue: 1 << 39)
    static let takesLessThanAnHour = WaypointAttributes(rawValue: 1 << 40)
    static let scenicView = WaypointAttributes(rawValue: 1 << 41)
    static let significantHike = WaypointAttributes(rawValue: 1 << 42)
    static let difficultClimbing = WaypointAttributes(rawValue: 1 << 43)
    static let mayRequireWading = WaypointAttributes(rawValue: 1 << 44)
    static let mayRequireSwimming = WaypointAttributes(rawValue: 1 << 45)
    static let availableAtAllTimes = WaypointAttributes(rawValue: 1 << 46)
    static let recommendedAtNight = WaypointAttributes(rawValue: 1 << 47)
    static let availableDuringWinter = WaypointAttributes(rawValue: 1 << 48)
    static let stealthRequired = WaypointAttributes(rawValue: 1 << 49)
    static let needsMaintenance = WaypointAttributes(rawValue: 1 << 50)
    static let watchForLivestock = WaypointAttributes(rawValue: 1 << 51)
    static let fieldPuzzle = WaypointAttributes(rawValue: 1 << 52)
    static let nightCache = WaypointAttributes(rawValue: 1 << 53)
    static let parkAndGrab = WaypointAttributes(rawValue: 1 << 54)
    static let abandonedStructure = WaypointAttributes(rawValue: 1 << 55)
    static let shortHike = WaypointAttributes(rawValue: 1 << 56) // < 1km
    static let mediumHike = WaypointAttributes(rawValue: 1 << 57) // 1km - 10km
    static let longHike = WaypointAttributes(rawValue: 1 << 58) // > 10km
    static let seasonalAccess = WaypointAttributes(rawValue: 1 << 59)
    static let touristFriendly = WaypointAttributes(rawValue: 1 << 60)
    static let frontYardPrivateResidence = WaypointAttributes(rawValue: 1 << 61)
    static let teamworkRequired = WaypointAttributes(rawValue: 1 << 62)
}
