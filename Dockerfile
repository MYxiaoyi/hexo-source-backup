FROM nginx:alpine

# ɾ��Ĭ������
RUN rm /etc/nginx/conf.d/default.conf

# �����Զ�������
COPY nginx.conf /etc/nginx/conf.d

# ������վ�ļ�
COPY public /usr/share/nginx/html

EXPOSE 80