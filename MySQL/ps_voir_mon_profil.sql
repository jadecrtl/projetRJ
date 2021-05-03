USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_voir_mon_profil;

DELIMITER #

CREATE PROCEDURE ps_voir_mon_profil (IN p_pseudonyme VARCHAR(40))
BEGIN
    DECLARE l_id_utilisateur INT;
    
    SET @l_id_utilisateur = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme);

    SELECT id_utilisateur, pseudonyme, adresse_mail, pouvoir
    FROM t_utilisateur
    WHERE id_utilisateur = @l_id_utilisateur;

END#

DELIMITER ;