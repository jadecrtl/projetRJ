USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_creer_publication;

DELIMITER #

CREATE PROCEDURE ps_creer_publication (IN p_pseudonyme VARCHAR(40), IN p_texte_publication TEXT)
BEGIN
    DECLARE l_id_utilisateur INT;
    DECLARE l_date_creation TIMESTAMP;
    
    SET @l_id_utilisateur = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme);

    SET @l_date_creation = (SELECT NOW());

    INSERT INTO t_publication (id_utilisateur, date_creation, texte_publication, statut_publication) 
    VALUES (@l_id_utilisateur, @l_date_creation, p_texte_publication, 'publiee');

END#

DELIMITER ;