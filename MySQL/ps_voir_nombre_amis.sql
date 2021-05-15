USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_voir_nombre_amis;

DELIMITER #

CREATE PROCEDURE ps_voir_nombre_amis(IN p_pseudonyme VARCHAR(40))
BEGIN 
    SELECT count(*) AS nb_abonnee
	FROM vue_amis a
	JOIN t_utilisateur u ON (a.id_utilisateur = u.id_utilisateur)
	WHERE u.pseudonyme = p_pseudonyme;
END#

DELIMITER ;