FROM ghcr.io/cirruslabs/flutter:3.24.3 AS build

WORKDIR /app

COPY . .

RUN flutter pub get

RUN flutter build web --release --target ./lib/main/main.dart --dart-define=SERVER_URL=http://0.0.0.0:8081/

FROM nginx:alpine

COPY --from=build /app/build/web /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8081

CMD ["nginx", "-g", "daemon off;"]