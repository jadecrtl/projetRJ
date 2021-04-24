USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_voir_fiche_adresse_mail;

DELIMITER #

CREATE PROCEDURE ps_voir_fiche_adresse_mail (IN p_adresse_mail VARCHAR(255))
BEGIN
    
    SELECT pseudonyme, adresse_mail, mot_de_passe, pouvoir 
    FROM t_utilisateur
    WHERE adresse_mail = p_adresse_mail;

END#

DELIMITER ;