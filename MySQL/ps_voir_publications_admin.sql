USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_voir_publications_admin;

DELIMITER #

CREATE PROCEDURE ps_voir_publications_admin (IN p_pseudonyme VARCHAR(40))
BEGIN
    DECLARE l_id_utilisateur INT;
    SET @l_id_utilisateur = NULL;

    SELECT @l_id_utilisateur := id_utilisateur 
    FROM t_utilisateur 
    WHERE pseudonyme = p_pseudonyme
    AND pouvoir = 'admin';

    IF (@l_id_utilisateur IS NOT NULL) THEN
        SELECT u.pseudonyme, p.texte_publication, p.date_creation
        FROM t_publication p
        JOIN t_utilisateur u ON (p.id_utilisateur = u.id_utilisateur)
        ORDER BY p.date_creation DESC;
    END IF;
END#

DELIMITER ;