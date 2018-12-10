FROM jetbrains/teamcity-agent

ENV TZ=Europe/Vilnius
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
 && apt-get install -y docker-compose php php-mbstring php-curl php-dom php-simplexml php-intl php-zip \
 && curl -sS https://getcomposer.org/installer \
      | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get install -y bsdtar && ln -sf $(which bsdtar) $(which tar)
