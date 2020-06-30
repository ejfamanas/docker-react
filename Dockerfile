# ------ BUILD PHASE ------ #
# Add in base operating system image
FROM alpine as builder
# create and set the new working director
WORKDIR /app
# Install some dependencies
RUN apk add --update nodejs
RUN apk add --update npm
# Copy package.json from local machine
COPY ./package.json ./
# Install package.json dependencies
RUN npm install
# Copy files over
COPY ./ ./
# execute
RUN npm run build
# ------ PRODUCTION PHASE ------ #
FROM nginx
# copy from the previous phase into nginx directory
COPY --from=builder /app/build /usr/share/nginx/html

