class Material < ApplicationRecord
  belongs_to :user
  has_many :project_materials, dependent: :destroy
  has_many :projects, through: :project_materials
  has_one_attached :photo

  # Required fields for a valid material
  validates :fabric_type, :fiber, :colour, presence: true
  validates :length, numericality: { greater_than: 0 }, allow_nil: true
  validates :width, numericality: { greater_than: 0 }, allow_nil: true
  validates :grams_per_square_meter, numericality: { greater_than: 0 }, allow_nil: true

  # Automatically fetch environmental metrics after creation.
  after_create :fetch_environmental_metrics

  def fetch_environmental_metrics
    metrics = calculate_environmental_metrics
    update(metrics)
  end

  # Calls the OpenAI API with a GPT prompt to estimate environmental metrics.
  def calculate_environmental_metrics
    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",  # Change this to a valid model if needed
        messages: [
          {
            role: "user",
            content: gpt_prompt
          }
        ]
      }
    )

    raw_content = response.dig("choices", 0, "message", "content").to_s.strip
    Rails.logger.info "AI Response for Material #{id}: #{raw_content}"
    data_parts = raw_content.split(",").map(&:strip)

    {
      water_usage:       (data_parts[0][/(\d+(\.\d+)?)/, 1] || "0").to_f,
      co2:               (data_parts[1][/(\d+(\.\d+)?)/, 1] || "0").to_f,
      electricity_used:  (data_parts[2][/(\d+(\.\d+)?)/, 1] || "0").to_f,
      summary:           data_parts[3..].join(" ").strip
    }
  end

  private

  def gpt_prompt
    <<~PROMPT
      You are an advanced environmental Life Cycle Assessment (LCA) expert
      with knowledge of average impacts across all known fabric types
      (natural, synthetic, semi-synthetic, etc.).

      When assessing each fabric, keep in mind the following
      "bad score thresholds" for 1m² of fabric:
        - Water usage: ~2,000 L/m² (e.g., conventional cotton can be very water-intensive)
        - CO₂ emissions: ~2 kg CO₂/m² (e.g., polyester or heavily processed fibers can be high)
        - Electricity usage: ~1 kWh/m² (synthetic fibers or high-energy processes)

      Additionally, account for:
        - Distance between the fabric's origin and its purchase location
          (transportation adds to CO₂).
        - The presence (or absence) of polyester or other synthetics in the fiber composition.
        - Any known certifications (e.g., GOTS, OEKO-TEX) that can lower impact or add disclaimers.
        - The type of fiber, color, weight (grams per square meter), and any relevant production details.

      Based on the data:
        - Fabric Type: #{fabric_type}
        - Fiber Composition: #{fiber}
        - Dimensions: Length: #{length}m, Width: #{width}cm, Weight: #{grams_per_square_meter} g/m²
        - Color: #{colour}
        - Origin: #{origin}
        - Purchase Location: #{purchase_location}
        - Certifications: #{certifications}

      Provide a realistic estimation of:
        1) Water usage in liters per m²
        2) CO₂ emissions in kg per m²
        3) Electricity consumption in kWh per m²
        4) A summary of up to 300 characters describing the fabric's environmental impact

      If you lack sufficient data to be precise, disclaim uncertainty rather than inventing data.
      Format the final answer without bullet points, symbols, or headings, using exactly
      the following structure (comma-separated):

      water_usage_value L/m², co2_value kg/m², electricity_value kWh/m², summary_text

      Example format:
      "120 L/m², 1.5 kg/m², 0.7 kWh/m², The fabric has a moderate environmental impact..."
    PROMPT
  end

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
