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

# Stage 2: Serve the static files with Nginx
FROM nginx:alpine AS production

# Remove the default Nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy the build output from the previous stage
COPY --from=build /usr/src/app/dist /usr/share/nginx/html

# Expose the default Nginx HTTP port
EXPOSE 8081

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
