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

# Stage 2: Minimal image with static files
FROM alpine:latest

# Set the working directory
WORKDIR /usr/share/nginx/html

# Copy the build output from the previous stage
COPY --from=build /usr/src/app/dist /usr/share/nginx/html

# No need to install Nginx; Coolify handles serving the files

# Optionally, set the entrypoint if required by Coolify
CMD ["sh"]
