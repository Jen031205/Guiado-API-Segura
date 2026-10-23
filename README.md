# Guiado-API-Segura

Secure Task Manager - Aplicación con API REST segura y cliente móvil.

## Estructura del Proyecto

- `backend/`: API REST desarrollada con Node.js, Express, Prisma ORM, autenticación JWT, Helmet y validaciones con Zod.
- `mobile/`: Aplicación móvil desarrollada en Flutter.

## Configuración y Ejecución

### Backend
1. Ir a la carpeta `backend`:
   ```bash
   cd backend
   ```
2. Instalar dependencias:
   ```bash
   npm install
   ```
3. Configurar variables de entorno basadas en `.env.example`.
4. Ejecutar migraciones e iniciar:
   ```bash
   npm run db:migrate
   npm run dev
   ```

### Mobile
1. Ir a la carpeta `mobile`:
   ```bash
   cd mobile
   ```
2. Instalar dependencias de Flutter:
   ```bash
   flutter pub get
   ```
3. Ejecutar la aplicación:
   ```bash
   flutter run
   ```
