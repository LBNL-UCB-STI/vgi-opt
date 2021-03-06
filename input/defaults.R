
#### Common ####
days <- c(1) 
# DEFAULT TIME PERIOD FOR PAPERS / FINAL ANALYSIS CORRECTED
#days <- c(70:73,176:178,260:262,351:354) # 3 per week, 2 weekday, 1 weekend plus 2 for buffer on ends
days <- 70:73

group.days <- 0 # set this to 0 to run all "days" at once, set to non-zero to run "grouped.days" at a time over the full range of "days" overlap occurs for one day on end-points

year <- 2040
discountRate <- 0.05

#### Mobility ####
electrificationPenetration <- 1.0 # how many of total trips are electrified
battery.capital.cost <- 150 # $/kWh
charger.levels <- c(10,20,50,100,250) # kW
chargerLifetime <- 10
sharingFactor <- 1.5
vmtReboundFactor <- 1.0 # scales VMT in the system, imperfectly, by scaling # trips for SAEVs and energy for private charging
batteryCapitalCost <- 150
vehicleCapitalCost <- 30000
b150ConversionEfficiency <- 0.324 # What is average conversion efficiency for a 150-mile BEV? kwh/mile, all other vehicle ranges
                                  # will be scaled proportionally assuming 0.324 as the default for BEV150
privateBEVConversionEfficiency <- 0.325 # EVI-Pro default was 0.325, this will adjust charging load proportionally for private BEVs
privateVehicleOccupancy <- 1.5
scale.urban.form.factor <- 1.0
includeTransitDemand <- 1 # 0 or 1
fractionSAEVs <- 0.5
fractionSmartCharging <- 0.5
privateFleetWeights <- "fleet_weights_base" # name (without extension) of file in {gem.raw.inputs}/NREL-EVI-Pro-Preprocessed-Profiles/data
congestion <- 'Freeflow'
l10ChargerCost <- 500 # $/kW
chargerCostSuperlinear <- 3 # rate of increase beyond linear from low to high power chargers
# Following is based on NHTS demand without transit and assumes 10 holidays per year and splits difference in remainder
weekday.to.year.factor <- 250.5 + 114.5*(19861098473/22232870872) # N_weekdays + N_weekends*(Demand_weekends/Demand_weekdays)
# Following is based on above but adjusted to account for runs with 2 weekdays + 1 weekend
weekday.to.year.factor <- 250.5*(250.5/365/.66666) + 114.5*(114.5/365/.33333)*(19861098473/22232870872) 

chts.trips <- fread(pp(gem.raw.inputs,'chts_triptimes.csv'))

#### Grid ####
generators <- fread(pp(gem.raw.inputs,'gem_gridInputs_generators.csv'))
load <- fread(pp(gem.raw.inputs,'gem_gridInputs_load.csv'))
transmission <- fread(pp(gem.raw.inputs,'gem_gridInputs_transmission.csv'))
transmissionScalingFactor <- 1.0
renewableCF <- fread(pp(gem.raw.inputs,'gem_gridInputs_renewableCF.csv'))

fuels <- data.frame('FuelType'=c('Wind','Waste Coal','Tire','Solar','Pumps','Pet. Coke','Oil','Nuclear','None','Non-Fossil','NaturalGas','MSW','LF Gas','Hydro','Geothermal','Fwaste','Coal','Biomass','Tires'),'Simplified'=c('Wind','Coal','Other','Solar','Other','Other','Other','Nuclear','Other','Other','Natural Gas','Other','Natural Gas','Hydro','Other','Other','Coal','Other','Other'))
meritOrder <- c('Solar','Wind','Hydro','Other','Natural Gas','Coal','Nuclear')

