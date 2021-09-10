FROM php:7.4-fpm
ARG uid=1000
ARG user=fgadmin
RUN apt-get updage & apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxm12-dev \
    zip \
    unzip 
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

#Create system user to run Composer and Artisan Commands 
RUN useradd -G www-data, root -u ${uid} -d /home/${user} ${user}
RUN mkdir -p /home/${user}/.composer && \
    chown -R ${user}:${user} /home/${user}

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer 

# Set working directory 
WORKDIR /var/www 

USER ${user}