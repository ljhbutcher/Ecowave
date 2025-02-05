import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["canvas", "score"]

  connect() {
    this.canvas = this.canvasTarget;
    this.ctx = this.canvas.getContext("2d");
    this.resizeCanvas();
    window.addEventListener("resize", () => this.resizeCanvas());

    const scoreText = this.scoreTarget.textContent.trim();
    const scoreNumber = parseInt(scoreText.split("/")[0]) || 0;
    this.averageScore = scoreNumber;

    this.initParticles();
    this.animate();
  }

  resizeCanvas() {
    // Set canvas to full window dimensions.
    this.canvas.width = window.innerWidth;
    this.canvas.height = window.innerHeight;
    this.centerX = this.canvas.width / 2;
    this.centerY = this.canvas.height / 2;
  }

  // New color mapping:
  // Score 0: dark purple (80, 0, 80)
  // Score 50: turquoise blue (64, 224, 208)
  // Score 100: green (0, 255, 0)
  getColorForScore(score) {
    let r, g, b;
    if (score <= 50) {
      const ratio = score / 50;
      // Interpolate between deep red and turquoise blue:
      // red: from 200 to 64
      r = Math.round(200 + ratio * (64 - 200)); // 200 -> 64
      // green: from 0 to 224
      g = Math.round(0 + ratio * (224 - 0));    // 0 -> 224
      // blue: from 20 to 208
      b = Math.round(20 + ratio * (208 - 20));   // 20 -> 208
    } else {
      const ratio = (score - 50) / 50;
      // Interpolate between turquoise blue and green:
      // red: from 64 to 0
      r = Math.round(64 + ratio * (0 - 64));      // 64 -> 0
      // green: from 224 to 255
      g = Math.round(224 + ratio * (255 - 224));    // 224 -> 255
      // blue: from 208 to 0
      b = Math.round(208 + ratio * (0 - 208));      // 208 -> 0
    }
    return `rgb(${r}, ${g}, ${b})`;
  }


  // Helper to adjust a color's brightness.
  // factor > 1 lightens; factor < 1 darkens.
  adjustColor(color, factor) {
    const match = color.match(/rgb\((\d+),\s*(\d+),\s*(\d+)\)/);
    if (!match) return color;
    let r = parseInt(match[1], 10);
    let g = parseInt(match[2], 10);
    let b = parseInt(match[3], 10);
    r = Math.min(255, Math.max(0, Math.round(r * factor)));
    g = Math.min(255, Math.max(0, Math.round(g * factor)));
    b = Math.min(255, Math.max(0, Math.round(b * factor)));
    return `rgb(${r}, ${g}, ${b})`;
  }

  initParticles() {
    this.particles = [];
    const numParticles = 70;  // Increase number for tighter grouping.
    const minOrbit = 120;
    const maxOrbit = 170;     // Smaller spread means particles are closer together.
    const particleColor = this.getColorForScore(this.averageScore);

    for (let i = 0; i < numParticles; i++) {
      const angle = Math.random() * Math.PI * 2;
      const orbitRadius = Math.random() * (maxOrbit - minOrbit) + minOrbit;
      const angularSpeed = 0.016;  // Adjust speed if needed.
      const radius = Math.random() * 1 + 0.5;  // Thinner particles.
      this.particles.push({
        angle,
        orbitRadius,
        angularSpeed,
        radius,
        x: this.centerX + orbitRadius * Math.cos(angle),
        y: this.centerY + orbitRadius * Math.sin(angle),
        color: particleColor
      });
    }
  }

  animate() {
    requestAnimationFrame(() => this.animate());

    // Fill the canvas with a semi-transparent white to create a trail.
    // (You can adjust the alpha value for longer or shorter trails.)
    this.ctx.fillStyle = "rgba(255, 255, 255, 0.1)";
    this.ctx.fillRect(0, 0, this.canvas.width, this.canvas.height);

    this.particles.forEach(particle => {
      // Update particle position.
      particle.angle += particle.angularSpeed;
      particle.x = this.centerX + particle.orbitRadius * Math.cos(particle.angle);
      particle.y = this.centerY + particle.orbitRadius * Math.sin(particle.angle);

      // Create a radial gradient from light to dark based on the particle's color.
      const lightColor = this.adjustColor(particle.color, 1.5); // 50% lighter
      const darkColor = this.adjustColor(particle.color, 0.7);  // 30% darker
      const gradient = this.ctx.createRadialGradient(
        particle.x, particle.y, 0,
        particle.x, particle.y, particle.radius
      );
      gradient.addColorStop(0, lightColor);
      gradient.addColorStop(1, darkColor);

      this.ctx.beginPath();
      this.ctx.arc(particle.x, particle.y, particle.radius, 0, Math.PI * 2);
      this.ctx.fillStyle = gradient;
      this.ctx.fill();
      this.ctx.closePath();
    });
  }
}
