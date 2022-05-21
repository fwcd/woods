//
//  WaypointAttribute.swift
//  Woods
//
//  Created by Fredrik on 3/3/21.
//  Copyright © 2021 Fredrik.
//

enum WaypointAttribute: UInt, CaseIterable, Codable, Hashable {
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
    case shortHike // < 1 km
    case mediumHike // 1-10 km
    case longHike // > 10 km
    case seasonalAccess
    case touristFriendly
    case frontYardPrivateResidence
    case teamworkRequired
    
    var name: String {
        switch self {
        // Permissions
        case .dogs: return "Dogs"
        case .bicycles: return "Bicycles"
        case .motorcycles: return "Motorcycles"
        case .quads: return "Quads"
        case .offRoadVehicles: return "Off-Road Vehicles"
        case .snowmobiles: return "Snowmobiles"
        case .horses: return "Horses"
        case .campfires: return "Campfires"
        case .truckDriverRV: return "Truck Driver RV"
        
        // Facilities
        case .wheelchairAvailable: return "Wheelchair Available"
        case .parkingAvailable: return "Parking Available"
        case .publicTransportation: return "Public Transportation"
        case .drinkingWaterNearby: return "Drinking Water Nearby"
        case .publicRestroomsNearby: return "Public Restrooms Nearby"
        case .telephoneNearby: return "Telephone Nearby"
        case .picnicTablesNearby: return "Picnic Tables Nearby"
        case .campingAvailable: return "Camping Available"
        case .strollerAvailable: return "Stroller Available"
        case .fuelNearby: return "Fuel Nearby"
        case .foodNearby: return "Food Nearby"
        
        // Equipment
        case .accessOrParkingFee: return "Access or Parking Fee"
        case .climbingGear: return "Climbing Gear"
        case .boat: return "Boat"
        case .scubaGear: return "Scuba Gear"
        case .flashlightRequired: return "Flashlight Required"
        case .uvLightRequired: return "UV Light Required"
        case .snowshoes: return "Snowshoes"
        case .crossCountrySkis: return "Cross-Country Skis"
        case .specialToolRequired: return "Special Tool Required"
        case .wirelessBeacon: return "Wireless Beacon"
        case .treeClimbing: return "Tree Climbing"
        
        // Hazards
        case .poisonousPlants: return "Poisonous Plants"
        case .dangerousAnimals: return "Dangerous Animals"
        case .ticks: return "Ticks"
        case .abandonedMines: return "Abandoned Mines"
        case .cliffFallingRocks: return "Cliff/Falling Rocks"
        case .hunting: return "Hunting"
        case .dangerousArea: return "Dangerous Area"
        case .thorns: return "Thorns"
        
        // Conditions
        case .recommendedForKids: return "Recommended For Kids"
        case .takesLessThanAnHour: return "Takes Less Than 1 Hour"
        case .scenicView: return "Scenic View"
        case .significantHike: return "Significant Hike"
        case .difficultClimbing: return "Difficult Climbing"
        case .mayRequireWading: return "May Require Wading"
        case .mayRequireSwimming: return "May Require Swimming"
        case .availableAtAllTimes: return "Available 24/7"
        case .recommendedAtNight: return "Recommended At Night"
        case .availableDuringWinter: return "Available During Winter"
        case .stealthRequired: return "Stealth Required"
        case .needsMaintenance: return "Needs Maintenance"
        case .watchForLivestock: return "Watch For Livestock"
        case .fieldPuzzle: return "Field Puzzle"
        case .nightCache: return "Night Cache"
        case .parkAndGrab: return "Park And Grab"
        case .abandonedStructure: return "Abandoned Structure"
        case .shortHike: return "Short Hike (< 1 km)"
        case .mediumHike: return "Medium Hike (1-10 km)"
        case .longHike: return "Long Hike (> 10 km)"
        case .seasonalAccess: return "Seasonal Access"
        case .touristFriendly: return "Tourist Friendly"
        case .frontYardPrivateResidence: return "Front Yard (Private Residence)"
        case .teamworkRequired: return "Teamwork Required"
        }
    }
}
