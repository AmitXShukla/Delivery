# bashCopy code
# Use the official Node.js image as the base image
FROM node:20

WORKDIR /app

COPY . /app
RUN npm -y -g install serve

ENV PORT 8080
EXPOSE 8080

# Install the application dependencies
# RUN npm install

# Define the entry point for the container
# CMD ["npm", "start"]
CMD ["serve", "web"]