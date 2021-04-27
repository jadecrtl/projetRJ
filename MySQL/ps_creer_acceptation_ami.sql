USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_creer_acceptation_ami;

DELIMITER #

CREATE PROCEDURE ps_creer_acceptation_ami (IN p_pseudonyme_demandeur VARCHAR(40), IN p_pseudonyme_repondant VARCHAR(40))
BEGIN
    DECLARE l_id_repondant INT;
    DECLARE l_id_demandeur INT;
    DECLARE l_relation_existante INT;

    SELECT @l_id_repondant := id_utilisateur_repondant 
    FROM t_utilisateur_relation 
    WHERE pseudonyme = p_pseudonyme_repondant AND relation = 'attente' AND pouvoir = 'prive';
    

    SELECT @l_id_demandeur := id_utilisateur_demandeur
    FROM t_utilisateur_relation
    WHERE pseudonyme = p_pseudonyme_demandeur;

    SELECT @l_relation_existante := COUNT(*)
    FROM t_utilisateur_relation
    WHERE id_utilisateur_demandeur = l_id_demandeur
    AND id_utilisateur_repondant = l_id_repondant;

    IF (@l_id_repondant IS NOT NULL AND @l_id_demandeur IS NOT NULL AND @l_relation_existante = 1 AND @l_id_demandeur <> @l_id_repondant) THEN    
        INSERT INTO t_utilisateur_relation (id_utilisateur_demandeur, id_utilisateur_repondant, relation)
        VALUES (@l_id_demandeur, @l_id_repondant, 'ami');
    END IF;
END#

DELIMITER ;
