USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_voir_mon_profil

DELIMITER #

CREATE PROCEDURE ps_voir_mon_profil (IN p_pseudonyme VARCHAR(40))
BEGIN
    DECLARE l_id_utilisateur INT;
    
    SELECT @l_id_utilisateur := id_utilisateur 
    FROM t_utilisateur 
    WHERE pseudonyme = p_pseudonyme;

END#

DELIMITER ;