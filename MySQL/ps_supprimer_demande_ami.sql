USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_supprimer_demande_ami;

DELIMITER #

CREATE PROCEDURE ps_supprimer_demande_ami (IN p_pseudonyme_demandeur VARCHAR(40), IN p_pseudonyme_repondant VARCHAR(40))
BEGIN
    DECLARE l_id_repondant INT;
    DECLARE l_id_demandeur INT;

    SET @l_id_demandeur = (
        SELECT id_utilisateur 
        FROM t_utilisateur
        WHERE pseudonyme = p_pseudonyme_demandeur);

    SET @l_id_repondant = (
        SELECT r.id_utilisateur_repondant 
        FROM t_utilisateur_relation r
        JOIN t_utilisateur u ON (u.id_utilisateur = r.id_utilisateur_repondant)
        WHERE u.pseudonyme = p_pseudonyme_repondant 
        AND r.id_utilisateur_demandeur = @l_id_demandeur
        AND r.relation = 'attente' 
        AND u.pouvoir = 'prive');

    IF (@l_id_repondant IS NOT NULL AND @l_id_demandeur IS NOT NULL AND @l_id_demandeur <> @l_id_repondant) THEN    
        UPDATE t_utilisateur_relation
        SET relation = 'refus'
        WHERE id_utilisateur_demandeur = @l_id_demandeur
        AND id_utilisateur_repondant = @l_id_repondant;
    END IF;
END#

DELIMITER ;
