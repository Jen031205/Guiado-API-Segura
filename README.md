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

   # Evidencia de funcionamiento
   1. Login
      <img width="921" height="357" alt="image" src="https://github.com/user-attachments/assets/2078f9a5-2a6a-4093-af93-4609ef224723" />

   2. Crear cuenta
      <img width="921" height="362" alt="image" src="https://github.com/user-attachments/assets/fe313ec3-4484-4fca-bff9-04cf42a9fdc9" />

   3. Pantalla inicial

      <img width="921" height="484" alt="image" src="https://github.com/user-attachments/assets/2c154359-c01c-4b38-a016-a2325010b5f6" />
      

   4. Creación de tarea
      <img width="921" height="493" alt="image" src="https://github.com/user-attachments/assets/5f60e4fd-4d45-448e-911a-6fdba4797f11" />

   5. Resultado de crear tarea
      <img width="921" height="228" alt="image" src="https://github.com/user-attachments/assets/3d39bf5f-6f22-4bbe-9da3-dc6d4a6a7907" />

   6. Eliminar tarea
      <img width="921" height="553" alt="image" src="https://github.com/user-attachments/assets/52c0cb49-d8eb-49c5-ae4c-1f7d11f3d7c7" />

   
   
