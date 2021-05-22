USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_voir_attentes;

DELIMITER #

CREATE PROCEDURE ps_voir_attentes (IN p_pseudonyme_repondant VARCHAR(40))
BEGIN

    DECLARE l_id_utilisateur_repondant INT;
    DECLARE l_pouvoir ENUM("admin", "prive", "public");
    SET @l_id_utilisateur_repondant = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme_repondant);
    SET @l_pouvoir = (SELECT pouvoir FROM t_utilisateur WHERE pseudonyme = p_pseudonyme_repondant);

    IF (@l_pouvoir = "public" OR @l_pouvoir = "admin")THEN

        SELECT pouvoir FROM t_utilisateur WHERE p_pseudonyme = p_pseudonyme_repondant;
    ELSE

        SELECT r.id_utilisateur_demandeur, u.pseudonyme, r.relation
        FROM t_utilisateur_relation r
        JOIN t_utilisateur u ON (u.id_utilisateur = r.id_utilisateur_demandeur) 
        WHERE r.id_utilisateur_repondant = @l_id_utilisateur_repondant
        AND r.relation = 'attente'
        ORDER BY u.pseudonyme ASC;

    END IF;

END#

DELIMITER ;
