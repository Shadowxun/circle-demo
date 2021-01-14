# build stage
FROM node:12 as build-stage

# 创建一个工作目录
WORKDIR /app

# 复制项目所有文件
COPY . .

RUN yarn install --registry https://registry.npm.taobao.org/

RUN yarn run build

# production stage
FROM nginx:stable-alpine as production-stage

COPY --from=build-stage /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
