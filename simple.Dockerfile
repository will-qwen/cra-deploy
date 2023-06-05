FROM node:14-alpine as builder
# ENV PUBLIC_URL https://aliyun-wb-b0dj2puxk2.oss-cn-shanghai.aliyuncs.com/

WORKDIR /code


ADD . /code
RUN npm run build



# 选择更小体积的基础镜像
FROM nginx:alpine
COPY --from=builder code/build /usr/share/nginx/html
