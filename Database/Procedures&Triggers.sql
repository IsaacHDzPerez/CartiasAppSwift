USE iborregos;
GO CREATE PROCEDURE sp_AddUsuarioEvento @UsuarioID numeric(18, 0),
    @EventoID numeric(18, 0) AS BEGIN
INSERT INTO USUARIOS_EVENTOS (USUARIO, EVENTO)
VALUES (@UsuarioID, @EventoID)
END
GO USE iborregos;
GO CREATE PROCEDURE sp_DeleteUsuarioEvento @UsuarioID numeric(18, 0),
    @EventoID numeric(18, 0) AS BEGIN
DELETE FROM USUARIOS_EVENTOS
WHERE USUARIO = @UsuarioID
    AND EVENTO = @EventoID
END
GO USE iborregos;
GO CREATE PROCEDURE sp_SelectEvento @EventoID numeric(18, 0) AS BEGIN
SELECT *
FROM EVENTOS
WHERE ID_EVENTO = @EventoID;
END
GO