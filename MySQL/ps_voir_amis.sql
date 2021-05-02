USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_voir_amis;

DELIMITER #

CREATE PROCEDURE ps_voir_amis (IN p_pseudonyme VARCHAR(40))
BEGIN

    DECLARE l_id_utilisateur INT;

    SET @l_id_utilisateur = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme);

    SELECT id_utilisateur_ami, pseudonyme, 'ami' relation
    FROM vue_amis
    WHERE id_utilisateur = @l_id_utilisateur
    ORDER BY pseudonyme ASC;

END#

DELIMITER ;
