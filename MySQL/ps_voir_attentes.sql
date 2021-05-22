USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_voir_attentes;

DELIMITER #

CREATE PROCEDURE ps_voir_attentes (IN p_pseudonyme_repondant VARCHAR(40))
BEGIN

    DECLARE l_id_utilisateur_repondant INT;
    SET @l_id_utilisateur_repondant = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme_repondant);

    SELECT r.id_utilisateur_demandeur, u.pseudonyme, r.relation
    FROM t_utilisateur_relation r
    JOIN t_utilisateur u ON (u.id_utilisateur = r.id_utilisateur_demandeur) 
    WHERE r.id_utilisateur_repondant = @l_id_utilisateur_repondant
    AND r.relation = 'attente'
    ORDER BY u.pseudonyme ASC;


END#

DELIMITER ;
