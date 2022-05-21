//
//  WaypointAttribute.swift
//  Woods
//
//  Created by Fredrik on 3/3/21.
//  Copyright © 2021 Fredrik.
//

enum WaypointAttribute: UInt, Codable, Hashable {
    // Permissions
    case dogs = 0
    case bicycles
    case motorcycles
    case quads
    case offRoadVehicles
    case snowmobiles
    case horses
    case campfires
    case truckDriverRV
    
    // Facilities
    case wheelchairAvailable
    case parkingAvailable
    case publicTransportation
    case drinkingWaterNearby
    case publicRestroomsNearby
    case telephoneNearby
    case picnicTablesNearby
    case campingAvailable
    case strollerAvailable
    case fuelNearby
    case foodNearby
    
    // Equipment
    case accessOrParkingFee
    case climbingGear
    case boat
    case scubaGear
    case flashlightRequired
    case uvLightRequired
    case snowshoes
    case crossCountrySkis
    case specialToolRequired
    case wirelessBeacon
    case treeClimbing
    
    // Hazards
    case poisonousPlants
    case dangerousAnimals
    case ticks
    case abandonedMines
    case cliffFallingRocks
    case hunting
    case dangerousArea
    case thorns
    
    // Conditions
    case recommendedForKids
    case takesLessThanAnHour
    case scenicView
    case significantHike
    case difficultClimbing
    case mayRequireWading
    case mayRequireSwimming
    case availableAtAllTimes
    case recommendedAtNight
    case availableDuringWinter
    case stealthRequired
    case needsMaintenance
    case watchForLivestock
    case fieldPuzzle
    case nightCache
    case parkAndGrab
    case abandonedStructure
    case shortHike
    case mediumHike
    case longHike
    case seasonalAccess
    case touristFriendly
    case frontYardPrivateResidence
    case teamworkRequired
}
