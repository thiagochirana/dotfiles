#!/bin/bash
set -euo pipefail

echo "🧩 Checking PostgreSQL..."

# Instala o PostgreSQL se ainda não estiver instalado
if ! command -v psql >/dev/null 2>&1; then
  echo "📦 Installing PostgreSQL..."
  sudo pacman -S --needed --noconfirm postgresql
else
  echo "✅ PostgreSQL already installed. Skipping setup."
  exit 0
fi

# Define variáveis
PGDATA="/var/lib/postgres/data"
PGUSER="postgres"
LOCAL_USER="$USER"

# Inicializa o banco se o diretório estiver vazio
if [ ! -d "$PGDATA/base" ]; then
  echo "⚙️  Initializing PostgreSQL cluster..."
  sudo su - postgres -c "initdb --locale=C.UTF-8 --encoding=UTF8 -D $PGDATA --data-checksums"
else
  echo "✅ PostgreSQL cluster already initialized."
fi

# Habilita e inicia o serviço
echo "🚀 Activating and starting PostgreSQL service..."
sudo systemctl enable postgresql
sudo systemctl start postgresql

# Cria usuário e banco local com o mesmo nome do usuário logado
echo "👤 Configuring user and local database ($LOCAL_USER)..."

sudo -u postgres psql <<SQL
DO
\$do\$
BEGIN
   IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = '$LOCAL_USER') THEN
      CREATE ROLE $LOCAL_USER WITH LOGIN SUPERUSER CREATEDB CREATEROLE;
      RAISE NOTICE 'User $LOCAL_USER created.';
   ELSE
      RAISE NOTICE 'User $LOCAL_USER already exists.';
   END IF;
END
\$do\$;

CREATE DATABASE $LOCAL_USER OWNER $LOCAL_USER;
SQL

echo
echo "✅ PostgreSQL configured successfully!"
echo "🔑 User: $LOCAL_USER"
echo "🗃️  Database:  $LOCAL_USER"
