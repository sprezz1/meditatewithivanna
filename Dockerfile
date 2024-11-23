# Stage 1: Build the Astro app
FROM node:18-alpine AS build

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json for dependency installation
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire app to the container
COPY . .

# Build the static site
RUN npm run build

# Stage 2: Serve the static files directly (optional)
# If you prefer to serve static files with a lightweight server, you can use something like `static-server` or `http-server`
# However, it's often unnecessary when using Coolify's built-in capabilities

# Alternatively, use a lightweight image to serve static files
FROM node:18-alpine AS production

# Install a lightweight static server, e.g., serve
RUN npm install -g serve

# Set the working directory
WORKDIR /usr/src/app

# Copy the build output from the previous stage
COPY --from=build /usr/src/app/dist ./dist

# Expose the port that the static server will run on (optional)
EXPOSE 5000

# Start the static server
CMD ["serve", "-s", "dist", "-l", "5000"]
