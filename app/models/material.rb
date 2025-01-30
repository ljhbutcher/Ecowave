class Material < ApplicationRecord
  has_many :projects, through: :project_materials
  has_many :project_materials, dependent: :destroy
  has_one_attached :photo

  # -------------------------------
  # 1) AI Method to fetch metrics
  # -------------------------------
  def calculate_environmental_metrics
    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [
          {
            role: "user",
            content: gpt_prompt
          }
        ]
      }
    )

    raw_content = response.dig("choices", 0, "message", "content").to_s.strip
    data_parts  = raw_content.split(",").map(&:strip)

    # Return a hash matching your DB columns
    {
      water_usage:       data_parts[0][/(\d+(\.\d+)?)/, 1].to_f,
      co2:               data_parts[1][/(\d+(\.\d+)?)/, 1].to_f,
      electricity_used:  data_parts[2][/(\d+(\.\d+)?)/, 1].to_f,
      summary:           data_parts[3..].join(" ").strip
    }
  end

  # -------------------------------
  # 2) Private GPT Prompt Method
  # -------------------------------
  private

  def gpt_prompt
    <<~PROMPT
      Based on the latest environmental regulations
      from the European Commission and the Paris Climate Accord,
      estimate the environmental impact of the following fabric:

      - Fabric Type: #{fabric_type}
      - Fiber Composition: #{fiber}
      - Dimensions: Length: #{length}m, Width: #{width}cm, Weight: #{grams_per_square_meter}g/m²
      - Color: #{colour}
      - Origin: #{origin}
      - Purchase Location: #{purchase_location}
      - Certifications: #{certifications}

      Only give me details for:
      - Water usage (liters per m²)
      - CO₂ emissions (kg per m²)
      - Electricity consumption (kWh per m²)
      Give me only the metrics without any bullet points,
      titles, symbols, followed by a 300-character summary of the fabric.
    PROMPT
  end

  # -------------------------------
  # 3) Validations & Aggregators
  # -------------------------------
  validates :length, numericality: { greater_than: 0 }, allow_nil: true
  validates :width,  numericality: { greater_than: 0 }, allow_nil: true
  validates :grams_per_square_meter, numericality: { greater_than: 0 }, allow_nil: true

  def self.avg_electricity
    average(:electricity_used)
  end

  def self.avg_water
    average(:water_usage)
  end

  def self.avg_co2
    average(:co2)
  end
end
