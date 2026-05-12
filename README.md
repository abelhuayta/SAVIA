# SAVIA: Sistema de Archivo de Videojuegos Indexados Online

## Descripción
SAVIA es una implementación física de base de datos en PostgreSQL diseñada para gestionar activos digitales y licencias de software. El sistema integra el control de desarrolladores, categorías de juegos y auditoría de accesos.

## Características Técnicas
- **Motor:** PostgreSQL 15+ / Supabase.
- **Identificadores:** Uso de `UUID` en la entidad Games para mayor seguridad.
- **Normalización:** Cumplimiento de la 3ra Forma Normal (3FN).
- **Auditoría:** Implementación de trazabilidad mediante campos `created`, `modified` y `status`.

## Diccionario de Datos
1. `categories`: Géneros y etiquetas de juegos.
2. `developers`: Información de los estudios creadores.
3. `games`: Datos principales de los videojuegos (Central).
4. `users`: Gestión de perfiles de usuario y saldo.
5. `licenses`: Tabla transaccional (Relación N:N entre Users y Games).
6. `accessLogs`: Historial de accesos por IP para auditoría de licencias.
