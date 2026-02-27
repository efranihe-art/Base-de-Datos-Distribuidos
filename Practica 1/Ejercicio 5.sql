-- 1. Crear el enlace apuntando a la IP 
EXEC sp_addlinkedserver 
   @server = 'SV_COMPA', 
   @srvproduct = 'SQLServer',
   @provider = 'MSOLEDBSQL',
   @datasrc = '192.168.1.50,1433', 
   @provstr = 'TrustServerCertificate=yes';
GO

-- 2. Poner las credenciales del servidor de la computadora 2
EXEC sp_addlinkedsrvlogin 
   @rmtsrvname = 'SV_SELF',
   @useself = 'false',
   @rmtuser = 'sa',
   @rmtpassword = '1111'; 
GO

-- 3. Habilitar RPC
EXEC sp_serveroption @server = 'SV_COMPA', @optname = 'rpc', @optvalue = 'true';
EXEC sp_serveroption @server = 'SV_COMPA', @optname = 'rpc out', @optvalue = 'true';
GO
-- 4. ¡La prueba de fuego!
EXEC sp_testlinkedserver N'SV_COMPA';
GO
