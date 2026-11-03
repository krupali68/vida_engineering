
import './App.css'

function App() {
  return (
    <>
      <header className="header">
        <a href="#home" className="brand">
          <span className="brand-icon">V</span>
          Vida Engineering
        </a>

        <nav>
          <a href="#home">Home</a>
          <a href="#about">About</a>
          <a href="#services">Services</a>
          <a href="#contact">Contact</a>
        </nav>
      </header>

      <main>
        <section id="home" className="hero">
          <div className="hero-content">
            <h1>Welcome to <span>Vida Engineering</span></h1>
            <p>Engineering solutions for a better tomorrow.</p>
            <a href="#contact" className="primary-btn">Get in Touch →</a>
          </div>
        </section>

        <section id="about" className="about">
          <div>
            <h2>About Us</h2>
            <div className="underline"></div>
            <p>
              At Vida Engineering, we are committed to delivering
              innovative and reliable engineering solutions.
              Our focus is on quality, precision and long-term value.
            </p>
          </div>
          <div className="about-visual">
            <span>BUILDING THE FUTURE</span>
            <strong>VIDA ENGINEERING</strong>
          </div>
        </section>

        <section id="services" className="services">
          <h2>Our Services</h2>
          <div className="service-grid">
            <div className="service-card">
              <div className="service-icon">⚙</div>
              <h3>Engineering Solutions</h3>
              <p>Smart and efficient solutions for your projects.</p>
            </div>
            <div className="service-card">
              <div className="service-icon">♙</div>
              <h3>Expert Support</h3>
              <p>Professional support at every step.</p>
            </div>
            <div className="service-card">
              <div className="service-icon">🤝</div>
              <h3>Reliable Partnership</h3>
              <p>Building long-term relationships with our clients.</p>
            </div>
          </div>
        </section>

        <section id="contact" className="contact">
          <div>
            <h2>Contact Us</h2>
            <p>Get in touch with our team to know more.</p>
          </div>
          <a href="mailto:info@vidaengineering.com" className="outline-btn">
            Let's Work Together →
          </a>
        </section>
      </main>

      <footer>
        <p>© 2026 Vida Engineering. All rights reserved.</p>
      </footer>
    </>
  )
}

export default App