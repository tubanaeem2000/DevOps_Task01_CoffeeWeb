# DevOps Docker Task — Assessment Guide

This guide walks you through the complete workflow required for the assignment:

**GitHub → Docker Build → Docker Hub → Docker Pull → Docker Container**

Follow the steps in order. Run every command in the **VS Code Terminal** (Terminal → New Terminal) unless stated otherwise. Take the listed screenshot at the end of each step for your submission.

---

## Project Files (included in this zip)

```
devops-docker-task/
├── index.html
├── style.css
└── Dockerfile
```

Place all three files directly inside one project folder named `devops-docker-task` (no subfolders). Open that folder in VS Code with **File → Open Folder**.

**Note on the website content:** the front-end has been redesigned as a polished, professional-looking "Roast & Bloom" coffee shop landing page (pure HTML5/CSS3, no JavaScript, no images, no frameworks) rather than a plain "DevOps Docker Task" demo page. This is intentional — the assignment is assessing your **Docker/DevOps workflow** (build, tag, push, pull, run), not the page's visible content, so the site now looks like a real small-business website while the underlying technical steps below stay identical.

---

## Step 1 — Test the Website Locally (Before Docker)

**What to do:** Double-click `index.html` on your computer to open it in your browser, or use the VS Code "Live Server" extension (right-click `index.html` → "Open with Live Server").

**Verify:** Page shows the "Roast & Bloom" navbar and logo, the hero headline "Crafted for Your Perfect Moment.", the animated glowing coffee cup (glowing outline, rolling coffee, rising steam, orbiting beans, flickering "Fresh Brew" sign), the menu cards, about section, feature cards, testimonial, CTA, and footer — all styled with warm cream/espresso/caramel coffee colors.

**Screenshot:** Browser showing the local website. Label it "Local Preview."

---

## Step 2 — Push the Project to GitHub

**2.1 Initialize Git in your project folder**

```
git init
```
Creates a hidden `.git` folder so Git starts tracking this project.

**2.2 Configure your identity (first time only, if not already done)**

```
git config --global user.name "Your Name"
git config --global user.email "your-email@example.com"
```
Tells Git who is making the commits.

**2.3 Stage and commit your files**

```
git add .
git commit -m "Initial commit: DevOps Docker Task static website"
```
`git add .` stages all files in the folder. `git commit` saves a snapshot with a message.

**Expected output:** A line like `3 files changed, ... insertions(+)`.

**2.4 Create the GitHub repository**
- Go to https://github.com/ → click the **+** icon (top right) → **New repository**
- Repository name: `devops-docker-task`
- Keep it **Public**
- Do **NOT** initialize with a README, .gitignore, or license (your local folder already has files)
- Click **Create repository**

**2.5 Connect and push your local project**

GitHub will show you commands — use these (replace `YOUR-USERNAME`):

```
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/devops-docker-task.git
git push -u origin main
```

- `git branch -M main` renames your branch to `main`.
- `git remote add origin ...` links your local repo to GitHub.
- `git push -u origin main` uploads your commit to GitHub.

**Verify:** Refresh your GitHub repository page — you should see `index.html`, `style.css`, and `Dockerfile` listed.

**Screenshot:** GitHub repository page showing your files. Label it "GitHub Repository."

**Git authentication issues:** GitHub no longer accepts your account password for `git push`. If prompted for a password and it fails, generate a Personal Access Token: GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic) → Generate new token → check the `repo` scope → Generate → copy the token and paste it as your password when Git asks. Alternatively, install **GitHub Desktop** or use `gh auth login` (GitHub CLI) to authenticate.

---

## Step 3 — Build the Docker Image Locally

**Before this step:** Make sure Docker Desktop is open and running (check with `docker ps` — no errors).

```
docker build -t devops-docker-task .
```
- `docker build` reads the `Dockerfile` and builds an image.
- `-t devops-docker-task` tags (names) the image so it's easy to reference.
- `.` tells Docker to use the current folder as the build context.

**Expected output:** Several "Step X/Y" lines ending with `Successfully tagged devops-docker-task:latest`.

**Verify:**
```
docker images
```
You should see `devops-docker-task` listed with a size and creation time.

**Screenshot:** Terminal output of `docker build` and `docker images`. Label it "Docker Image Built."

---

## Step 4 — Run the Container Locally

```
docker run -d -p 8080:80 --name docker-task-container devops-docker-task
```
- `-d` runs the container in the background (detached).
- `-p 8080:80` maps port 8080 on your computer to port 80 inside the container (where Nginx listens).
- `--name` gives the container a friendly name.

**Verify it's running:**
```
docker ps
```
You should see `docker-task-container` with status `Up`.

**Verify in browser:** Open `http://localhost:8080` — your website should load exactly as it did locally.

**Screenshot:** Browser showing the site at `localhost:8080`, plus terminal output of `docker ps`. Label it "Container Running Locally."

**Stop and remove the container (when needed):**
```
docker stop docker-task-container
docker rm docker-task-container
```
`stop` shuts it down; `rm` deletes the stopped container so the name is free to reuse.

---

## Step 5 — Create a Docker Hub Repository

- Go to https://hub.docker.com/ → log in
- Click **Create Repository**
- Name: `devops-docker-task`
- Visibility: Public
- Click **Create**

**Screenshot:** Docker Hub repository page (empty, before pushing). Label it "Docker Hub Repository Created."

---

## Step 6 — Log In to Docker Hub from the Terminal

```
docker login
```
Enter your Docker Hub username and password (or access token) when prompted.

**Expected output:** `Login Succeeded`.

**Docker Hub login issues:** If password login fails, create an Access Token: Docker Hub → Account Settings → Security → New Access Token → use that token as the password.

---

## Step 7 — Tag the Image for Docker Hub

Docker Hub requires images to be named `your-dockerhub-username/repository-name`.

```
docker tag devops-docker-task YOUR-DOCKERHUB-USERNAME/devops-docker-task:v1
```
Replace `YOUR-DOCKERHUB-USERNAME` with your actual Docker Hub username. `v1` is the version tag.

**Verify:**
```
docker images
```
You should now see both `devops-docker-task` and `YOUR-DOCKERHUB-USERNAME/devops-docker-task` listed.

---

## Step 8 — Push the Image to Docker Hub

```
docker push YOUR-DOCKERHUB-USERNAME/devops-docker-task:v1
```

**Expected output:** Layer upload progress bars ending with the tag digest.

**Verify:** Refresh your Docker Hub repository page in the browser — the `v1` tag should now appear under "Tags."

**Screenshot:** Docker Hub repository page showing the pushed `v1` tag. Label it "Image Pushed to Docker Hub."

---

## Step 9 — Pull the Image Back from Docker Hub

To prove the image genuinely works from Docker Hub (not just your local build), remove your local copies first, then pull fresh:

```
docker rmi YOUR-DOCKERHUB-USERNAME/devops-docker-task:v1
docker pull YOUR-DOCKERHUB-USERNAME/devops-docker-task:v1
```
`rmi` removes the local image. `pull` downloads it fresh from Docker Hub.

**Expected output:** Download progress ending with `Status: Downloaded newer image for ...`.

**Screenshot:** Terminal output of `docker pull`. Label it "Image Pulled from Docker Hub."

---

## Step 10 — Run a New Container from the Pulled Image

```
docker run -d -p 8081:80 --name pulled-task-container YOUR-DOCKERHUB-USERNAME/devops-docker-task:v1
```
Uses a different port (`8081`) and container name so it doesn't clash with anything still running.

**Verify:**
```
docker ps
```
Then open `http://localhost:8081` in your browser — the website should load, proving the image works correctly straight from Docker Hub.

**Screenshot:** Browser showing the site at `localhost:8081` plus `docker ps` output. Label it "Verified — Pulled Image Working."

---

## Cleanup (optional, after you're done demonstrating)

```
docker stop docker-task-container pulled-task-container
docker rm docker-task-container pulled-task-container
```

---

## Troubleshooting

**`docker` command not recognized:** Docker Desktop isn't installed, or your terminal was opened before installing it — close and reopen VS Code, or restart your computer.

**Docker Desktop not running:** Open the Docker Desktop application and wait until the whale icon is steady (not animating) before running any `docker` command.

**Port already in use** (e.g., `8080` busy): Use a different host port, e.g. `-p 8090:80`, then browse to `localhost:8090`.

**Git authentication issues:** Use a Personal Access Token instead of your password (see Step 2.5), or use GitHub Desktop / `gh auth login`.

**Docker Hub login issues:** Use an Access Token instead of your account password (see Step 6).

**Image not found (`pull access denied` / `manifest unknown`):** Double-check the exact spelling of `YOUR-DOCKERHUB-USERNAME/devops-docker-task:v1` — it must match what you pushed, and the repository must be Public.

**Permission denied (Linux/Mac):** Prefix the command with `sudo`, e.g. `sudo docker ps`, or add your user to the `docker` group (`sudo usermod -aG docker $USER`, then log out and back in).

**Container immediately stopping:** Check logs with `docker logs docker-task-container`. The most common cause is a Dockerfile `CMD` that isn't running in the foreground — this Dockerfile already handles that correctly with `CMD ["nginx", "-g", "daemon off;"]`.

---

## Final Submission Checklist

- [ ] GitHub repository with `index.html`, `style.css`, `Dockerfile`
- [ ] Screenshot: Local website preview
- [ ] Screenshot: GitHub repository page
- [ ] Screenshot: `docker build` + `docker images` output
- [ ] Screenshot: Container running locally (browser + `docker ps`)
- [ ] Screenshot: Docker Hub repository created
- [ ] Screenshot: Image pushed to Docker Hub (tag visible)
- [ ] Screenshot: `docker pull` output
- [ ] Screenshot: Pulled image running in a new container (browser + `docker ps`)
