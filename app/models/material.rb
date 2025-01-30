class Material < ApplicationRecord
  has_many :projects, through: :project_materials
  has_many :project_materials, dependent: :destroy
  has_one_attached :photo

  def content
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [
        {
          role: "user",
          content: "
            Based on the latest environmental regulations
            from the European Commission and the Paris Climate Accord,
            estimate the environmental impact of the following fabric:

            - **Fabric Type:** #{name}
            - **Fiber Composition:**
            - **Weight:** #{weight}
            - **Supplier:** #{supplier}
            - **Dimensions:** Length: in cm, Width: in cm, Weight in g/m²
            - **Amount:** #{amount}
            - **Color:**
            - **Origin:** #{origin_production}
            - **Purchase Location:** #{purchase_location}
            - **Certifications:**
             Only give me details for:
            - Water usage (liters per m²)
            - CO₂ emissions (kg per m²)
            - Electricity consumption (kWh per m²)
            Give me only the metrics without any bullet points,
            titles, symbols, followed by a 300-character summary of the fabric.
          "
        }
      ]
    })

    # Extract raw content from the API response
    raw_content = chatgpt_response["choices"][0]["message"]["content"].strip

    # Split the raw content into lines
    lines = raw_content.split("\n").map(&:strip)

    # Create a hash with parsed values
    metrics = {
      water_usage: parse_value(lines[0]),
      co2_emissions: parse_value(lines[1]),
      electricity_consumption: parse_value(lines[2]),
      summary: lines[3..].join(" ").strip
    }
    format_string(metrics)
  end

  private

  # Parse numeric value from the line
  def parse_value(line)
    return nil if line.nil?

    # Extract the first numeric value and unit from the line
    match = line.match(/(\d+(\.\d+)?)(\s?[a-zA-Z]+\/m²)?/)
    if match
      value = match[1].to_f
      unit = match[3] # captures unit (L/m², kg/m², etc.)
      value
    else
      nil
    end
  end

  # Method to format the output
  def format_string(metrics)
    <<~OUTPUT
      <ul>
        <li>Water_usage: #{metrics[:water_usage]} L/m²</li>
        <li>Co2_emissions: #{metrics[:co2_emissions]} kg/m²</li>
        <li>Electricity_consumption: #{metrics[:electricity_consumption]} kWh/m²</li>
        <li>Summary: #{metrics[:summary]}</li>
      </ul>
    OUTPUT
  end
  validates :length, numericality: { greater_than: 0 }, allow_nil: true
  validates :width, numericality: { greater_than: 0 }, allow_nil: true
  validates :grams_per_square_meter, numericality: { greater_than: 0 }, allow_nil: true

  def self.avg_electricity
    average(:electricity_used)
  end

  def self.avg_water
    average(:water_usage)
  end

  def self.avg_co2
    average(:CO2)
  end

end
