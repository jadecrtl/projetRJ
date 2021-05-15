USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_voir_mes_publications;

DELIMITER #

CREATE PROCEDURE ps_voir_mes_publications (IN p_pseudonyme VARCHAR(40))
BEGIN
    DECLARE l_id_utilisateur INT;
    
    SET @l_id_utilisateur = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme);

    SELECT u.pseudonyme, p.texte_publication, p.date_creation
    FROM t_publication p
    JOIN t_utilisateur u ON (p.id_utilisateur = u.id_utilisateur)
    WHERE u.id_utilisateur = @l_id_utilisateur
    AND statut_publication = 'publiee'
    ORDER BY date_creation DESC;

END#

DELIMITER ;