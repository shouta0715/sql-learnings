# MySQL Image
FROM mysql:8.0

EXPOSE 3306

COPY ./my.cnf /etc/mysql/conf.d/my.cnf

CMD ["mysqld"]