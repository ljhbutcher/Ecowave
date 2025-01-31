# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Seed data for the materials table (fabrics)
Material.destroy_all

puts "Creating seed files"

Material.create!([
  {
    name: "Cotton",
    weight: 500.0,
    supplier: "EcoTextiles Co.",
    origin: "India",
    purchase_location: "Mumbai, India",
    co2: 250.0,
    water_usage: 1500.0,
    electricity_used: 300.0
  },
  {
    name: "Polyester",
    weight: 300.0,
    supplier: "Global Fabrics Ltd.",
    origin: "China",
    purchase_location: "Shanghai, China",
    co2: 800.0,
    water_usage: 500.0,
    electricity_used: 1200.0
  },
  {
    name: "Silk",
    weight: 100.0,
    supplier: "Luxury Threads",
    origin: "Thailand",
    purchase_location: "Bangkok, Thailand",
    co2: 150.0,
    water_usage: 200.0,
    electricity_used: 400.0
  },
  {
    name: "Wool",
    weight: 400.0,
    supplier: "Shepherd Supplies",
    origin: "New Zealand",
    purchase_location: "Auckland, New Zealand",
    co2: 300.0,
    water_usage: 800.0,
    electricity_used: 250.0
  },
  {
    name: "Linen",
    weight: 200.0,
    supplier: "Natural Fabrics Co.",
    origin: "Belgium",
    purchase_location: "Brussels, Belgium",
    co2: 100.0,
    water_usage: 400.0,
    electricity_used: 150.0
  },
  {
    name: "Tencel",
    weight: 220.0,
    supplier: "Lenzing AG",
    origin_production: "Austria",
    purchase_location: "Lenzing, Austria",
    co2: 350.0,
    water_usage: 700.0,
    electricity_used: 500.0
  },
  {
    name: "Jute",
    weight: 450.0,
    supplier: "Jute World",
    origin_production: "India",
    purchase_location: "Kolkata, India",
    co2: 150.0,
    water_usage: 500.0,
    electricity_used: 220.0
  },
  {
    name: "Modal",
    weight: 210.0,
    supplier: "Lenzing AG",
    origin_production: "Austria",
    purchase_location: "Lenzing, Austria",
    co2: 300.0,
    water_usage: 600.0,
    electricity_used: 450.0
  },
  {
    name: "Corduroy",
    weight: 420.0,
    supplier: "Textile Hub",
    origin_production: "USA",
    purchase_location: "North Carolina, USA",
    co2: 450.0,
    water_usage: 900.0,
    electricity_used: 600.0
  },
  {
    name: "Denim",
    weight: 480.0,
    supplier: "Blue Ridge Denim",
    origin_production: "USA",
    purchase_location: "South Carolina, USA",
    co2: 550.0,
    water_usage: 1200.0,
    electricity_used: 750.0
  },
  {
    name: "Rayon",
    weight: 250.0,
    supplier: "Sustainable Textiles",
    origin: "Indonesia",
    purchase_location: "Jakarta, Indonesia",
    co2: 500.0,
    water_usage: 1000.0,
    electricity_used: 700.0
  }
])

Project.create!([
  {
    name: "Summer collection",
    description: "exploring pink tones"
  },
  {
    name: "Winter Collection",
    description: "coats and knits"
  },
  {
    name: "Evening Dresses",
    description: "range of dark colours"
  }
])

puts "#{Material.count} seed files created"
