CarbonSource.create(
  name: "Fuel Oil",
  conversion_factor: 22.61,
  units: "gallons"
)
CarbonSource.create(
  name: "Natural Gas",
  conversion_factor: 0.12,
  units: "cubic feet"
)
CarbonSource.create(
  name: "Propane",
  conversion_factor: 12.43,
  units: "gallons"
)

UseReason.create(name: "Home")
UseReason.create(name: "Travel")
UseReason.create(name: "Work")
