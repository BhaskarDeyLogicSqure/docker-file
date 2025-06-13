# FROM ubuntu

# RUN apt-get update
# RUN apt-get install -y curl
# RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
# RUN apt-get upgrade -y

# RUN apt-get install -y nodejs

# COPY package.json package-lock.json
# COPY package-lock.json package-lock.json
# COPY main.js main.js


# RUN npm install --legacy-peer-deps

# ENTRYPOINT [ "node", "main.js" ]


# FROM ubuntu

# # Set working directory
# WORKDIR /app

# # Install curl, Node.js 18, and nodemon globally
# RUN apt-get update && \
#     apt-get install -y curl && \
#     curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
#     apt-get install -y nodejs && \
#     npm install -g nodemon

# # Copy dependency files first (to leverage Docker cache)
# COPY package*.json ./

# # Install node dependencies
# RUN npm install --legacy-peer-deps || npm cache clean --force

# # Copy the rest of your app
# COPY . .

# # Start the app
# ENTRYPOINT ["npm", "start"]


FROM node:24.2.0-alpine3.22 as builder

WORKDIR /app
# Copy dependency files first (to leverage Docker cache)
COPY package*.json ./
# Install node dependencies
RUN npm install --legacy-peer-deps || npm cache clean --force
# Copy the rest of your app
COPY . .
# Build the app (if needed, e.g., for TypeScript or other build steps)
# RUN npm run build
FROM node:24.2.0-alpine3.22 as runner
WORKDIR /app
# Copy the built app from the builder stage
COPY --from=builder /app .
# Start the app
ENTRYPOINT ["npm", "run", "dev"]
# Expose the port your app runs on
EXPOSE 3000
EXPOSE 9229
