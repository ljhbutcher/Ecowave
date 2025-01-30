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

puts "creating seed files"

Material.create!([
  {
    name: "Cotton",
    weight: 500.0,
    supplier: "EcoTextiles Co.",
    origin: "India",
    purchase_location: "Mumbai, India",
    CO2: 250.0,
    water_usage: 1500.0,
    electricity_used: 300.0,
    created_at: Time.now,
    updated_at: Time.now
  },
  {
    name: "Polyester",
    weight: 300.0,
    supplier: "Global Fabrics Ltd.",
    origin: "China",
    purchase_location: "Shanghai, China",
    CO2: 800.0,
    water_usage: 500.0,
    electricity_used: 1200.0,
    created_at: Time.now,
    updated_at: Time.now
  },
  {
    name: "Silk",
    weight: 100.0,
    supplier: "Luxury Threads",
    origin: "Thailand",
    purchase_location: "Bangkok, Thailand",
    CO2: 150.0,
    water_usage: 200.0,
    electricity_used: 400.0,
    created_at: Time.now,
    updated_at: Time.now
  },
  {
    name: "Wool",
    weight: 400.0,
    supplier: "Shepherd Supplies",
    origin: "New Zealand",
    purchase_location: "Auckland, New Zealand",
    CO2: 300.0,
    water_usage: 800.0,
    electricity_used: 250.0,
    created_at: Time.now,
    updated_at: Time.now
  },
  {
    name: "Linen",
    weight: 200.0,
    supplier: "Natural Fabrics Co.",
    origin: "Belgium",
    purchase_location: "Brussels, Belgium",
    CO2: 100.0,
    water_usage: 400.0,
    electricity_used: 150.0,
    created_at: Time.now,
    updated_at: Time.now
  },
  {
    name: "Rayon",
    weight: 250.0,
    supplier: "Sustainable Textiles",
    origin: "Indonesia",
    purchase_location: "Jakarta, Indonesia",
    CO2: 500.0,
    water_usage: 1000.0,
    electricity_used: 700.0,
    created_at: Time.now,
    updated_at: Time.now
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
