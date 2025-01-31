# Clear existing data to avoid duplication
Material.destroy_all
Project.destroy_all

puts "Seeding materials..."

Material.create!([
  {
    fabric_type: "Cotton",
    fiber: "100% Cotton",
    length: 50.0,
    width: 150.0,
    grams_per_square_meter: 500.0,
    colour: "White",
    texture: "Smooth",
    origin: "India",
    supplier: "EcoTextiles Co.",
    product_code: "COT-123",
    purchase_location: "Mumbai, India",
    purchase_date: Date.new(2023, 5, 15),
    price_per_meter: 12.99,
    certifications: "GOTS Certified",
    co2: 250.0,
    water_usage: 1500.0,
    electricity_used: 300.0,
    notes: "Organic cotton with high durability."
  },
  {
    fabric_type: "Polyester",
    fiber: "100% Polyester",
    length: 75.0,
    width: 140.0,
    grams_per_square_meter: 300.0,
    colour: "Black",
    texture: "Glossy",
    origin: "China",
    supplier: "Global Fabrics Ltd.",
    product_code: "POL-456",
    purchase_location: "Shanghai, China",
    purchase_date: Date.new(2023, 6, 20),
    price_per_meter: 8.99,
    certifications: "OEKO-TEX Standard 100",
    co2: 800.0,
    water_usage: 500.0,
    electricity_used: 1200.0,
    notes: "Recycled polyester suitable for activewear."
  },
  {
    fabric_type: "Silk",
    fiber: "100% Silk",
    length: 30.0,
    width: 120.0,
    grams_per_square_meter: 100.0,
    colour: "Ivory",
    texture: "Soft",
    origin: "Thailand",
    supplier: "Luxury Threads",
    product_code: "SLK-789",
    purchase_location: "Bangkok, Thailand",
    purchase_date: Date.new(2023, 7, 10),
    price_per_meter: 45.99,
    certifications: "Natural Silk Association Certified",
    co2: 150.0,
    water_usage: 200.0,
    electricity_used: 400.0,
    notes: "Premium grade silk for luxury garments."
  }
])

puts "#{Material.count} materials created!"

puts "Seeding projects..."

Project.create!([
  {
    name: "Summer Collection",
    description: "Exploring pink tones"
  },
  {
    name: "Winter Collection",
    description: "Coats and knits"
  },
  {
    name: "Evening Dresses",
    description: "Range of dark colors"
  }
])

puts "#{Project.count} projects created!"
