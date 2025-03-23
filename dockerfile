FROM node:20-alpine

WORKDIR /app

COPY package.json .

RUN npm config set registry https://registry.npmmirror.com

RUN npm install

COPY . .

RUN npm run build

FROM nginx:alpine

RUN mkdir -p /usr/share/nginx/html

COPY --from=0 /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

# docker build -t my-app .
# docker run -p 80:80 my-app
