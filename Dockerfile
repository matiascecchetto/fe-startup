FROM node:alpine AS build
WORKDIR '/app'
COPY package.json ./
RUN npm install
COPY ./ ./
RUN npm run build

FROM nginx:alpine
EXPOSE 80
COPY --from=build /app/build usr/share/nginx/html
ARG nginx_amplify_key
ENV nginx_amplify_key=$nginx_amplify_key
RUN curl -L -O https://github.com/nginxinc/nginx-amplify-agent/raw/master/packages/install.sh
RUN wget https://github.com/nginxinc/nginx-amplify-agent/raw/master/packages/install.sh
RUN API_KEY=nginx_amplify_key sh ./install.sh
