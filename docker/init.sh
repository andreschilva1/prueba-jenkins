
#!/bin/bash

# Si el vendor no existe, instala dependencias
if [ ! -d "vendor" ]; then
    echo "Instalando dependencias con Composer..."
    composer install
fi

# Copiar .env si no existe
if [ ! -f ".env" ]; then
    echo "Copiando archivo .env..."
    cp .env.example .env
fi

# Generar APP_KEY
php artisan key:generate
php artisan migrate --force

# Permisos
chown -R www-data:www-data storage bootstrap/cache
chmod -R 775 storage bootstrap/cache

# Iniciar Apache
echo "Listo. Iniciando Apache..."
apache2-foreground