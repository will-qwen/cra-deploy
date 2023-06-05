FROM node:14-alpine as builder


# ENV PUBLIC_URL https://aliyun-wb-b0dj2puxk2.oss-cn-shanghai.aliyuncs.com/





# 单独分离 package.json，是为了安装依赖可最大限度利用缓存
ADD package.json yarn.lock /code/
RUN yarn

ADD . /code
RUN npm run build  

# 选择更小体积的基础镜像
FROM nginx:alpine
ADD nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder code/build /usr/share/nginx/html
