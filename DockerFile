# Usa uma imagem oficial do PHP com Apache embutido
FROM php:8.2-apache

# Instula extensões essenciais que o WordPress e o PHP costumam precisar
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd mysqli pdo_mysql zip

# Habilita o mod_rewrite do Apache (essencial para as URLs amigáveis do WordPress)
RUN a2enmod rewrite

# Copia os arquivos do projeto para a pasta pública do Apache no container
COPY . /var/www/html/

# Ajusta as permissões da pasta para o Apache conseguir ler/escrever
RUN chown -R www-data:www-data /var/www/html

# Expõe a porta padrão que o Render vai escutar
EXPOSE 80
