# Roast & Bloom

A static coffee shop website (HTML + CSS) containerized with Docker and served by Nginx.

## Project Structure

```
.
├── Dockerfile      # Builds an nginx:alpine image serving the site
├── index.html      # Website markup
├── style.css       # Website styles
└── README.md
```

## Run with Docker

Build the image:

```bash
docker build -t roast-and-bloom .
```

Run the container:

```bash
docker run -d -p 8080:80 --name roast-and-bloom roast-and-bloom
```

Then open http://localhost:8080 in your browser.

Stop and remove the container:

```bash
docker stop roast-and-bloom && docker rm roast-and-bloom
```

## Run Without Docker

Just open `index.html` in any browser.
