USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_voir_notifications;

DELIMITER #

CREATE PROCEDURE ps_voir_notifications (IN p_pseudonyme VARCHAR(255))
BEGIN
    
    SELECT count(*) AS nb_notif
    FROM t_utilisateur_relation r
    JOIN t_utilisateur u ON (r.id_utilisateur_repondant = u.id_utilisateur)
    WHERE u.pseudonyme = p_pseudonyme
    AND r.relation = 'attente';
    
END#

DELIMITER ;