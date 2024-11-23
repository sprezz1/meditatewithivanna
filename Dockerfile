# Use an official Node.js image
FROM node:18-alpine

# Set working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application
COPY . .

# Build the project for production
RUN npm run build

# Expose the port your app will run on
EXPOSE 4321

# Start the production build using preview
CMD ["npm", "run", "preview", "--", "--host"]
