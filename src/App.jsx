import { useEffect, useState } from 'react'
import './App.css'
import { getHomepage } from './sanity'

function App() {
  const [homepage, setHomepage] = useState(null)

  useEffect(() => {
    getHomepage()
      .then((data) => {
        setHomepage(data)
      })
      .catch((error) => {
        console.error('Error fetching homepage:', error)
      })
  }, [])

  if (!homepage) {
    return <p>Loading homepage...</p>
  }

  return (
    <>

      <header className="header">
        <a href="#home" className="brand">
          <span className="brand-icon">V</span>
          {homepage.companyName}
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
            <h1>{homepage.heroHeading}</h1>
            <p>{homepage.heroTagline}</p>
            <a href="#contact" className="primary-btn">Get in Touch →</a>
          </div>
        </section>

        <section id="about" className="about">
          <div>
            <h2>{homepage.aboutHeading}</h2>
            <div className="underline"></div>
            <p>{homepage.aboutDescription}</p>
          </div>
          <div className="about-visual">
            <span>{homepage.aboutVisualTopline}</span>
            <strong>{homepage.aboutVisualTitle}</strong>
          </div>
        </section>

        <section id="services" className="services">
          <h2>{homepage.servicesHeading}</h2>
          <div className="service-grid">
            {homepage.services?.map((service) => (
              <div className="service-card" key={service._key}>
                <div className="service-icon">{service.icon}</div>
                <h3>{service.title}</h3>
                <p>{service.description}</p>
              </div>
            ))}
          </div>
        </section>

        <section id="contact" className="contact">
          <div>
            <h2>{homepage.contactHeading}</h2>
            <p>{homepage.contactDescription}</p>
          </div>
          <a href={`mailto:${homepage.contactEmail}`} className="outline-btn">
            Let's Work Together →
          </a>
        </section>
      </main>

      <footer>
        <p>{homepage.footerText}</p>
      </footer>
    </>
  )
}

export default App