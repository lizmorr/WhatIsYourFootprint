CarbonSource.create(
  name: "Fuel Oil",
  conversion_factor: 22.61,
  units: "gallons",
  citation: "Environmental Protection Agency (EPA)",
  citation_url: "http://epa.gov/climatechange/ghgemissions/ind-assumptions.html"
)
CarbonSource.create(
  name: "Natural Gas",
  conversion_factor: 0.12,
  units: "therms",
  citation: "Environmental Protection Agency (EPA)",
  citation_url: "http://epa.gov/climatechange/ghgemissions/ind-assumptions.html"
)
CarbonSource.create(
  name: "Propane",
  conversion_factor: 12.43,
  units: "gallons",
  citation: "Environmental Protection Agency (EPA)",
  citation_url: "http://epa.gov/climatechange/ghgemissions/ind-assumptions.html"
)
CarbonSource.create(
  name: "Electricity",
  conversion_factor: 1.13,
  units: "kWhs",
  citation: "Blue Sky",
  citation_url: "http://blueskymodel.org/kilowatt-hour"
)
CarbonSource.create(
  name: "Unleaded Gas",
  conversion_factor: 19.64,
  units: "gallons",
  citation: "U.S Energy Information Administration (EIA)",
  citation_url: "http://www.eia.gov/tools/faqs/faq.cfm?id=307&t=11"
)

UseReason.create(name: "Home")
UseReason.create(name: "Travel")
UseReason.create(name: "Work")
