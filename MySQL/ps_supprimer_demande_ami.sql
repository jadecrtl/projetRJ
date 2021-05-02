USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_creer_supprimer_demande_ami;

DELIMITER #

CREATE PROCEDURE ps_creer_supprimer_demande_ami (IN p_pseudonyme_demandeur VARCHAR(40), IN p_pseudonyme_repondant VARCHAR(40))
BEGIN
    DECLARE l_id_repondant INT;
    DECLARE l_id_demandeur INT;
    DECLARE l_relation_existante INT;

    SET @l_id_repondant = (SELECT id_utilisateur_repondant FROM t_utilisateur_relation WHERE pseudonyme = p_pseudonyme_repondant AND relation = 'attente' AND pouvoir = 'prive');
    

    SET @l_id_demandeur = (SELECT id_utilisateur_demandeur FROM t_utilisateur_relation WHERE pseudonyme = p_pseudonyme_demandeur);

    SET @l_relation_existante = (SELECT COUNT(*) FROM t_utilisateur_relation WHERE id_utilisateur_demandeur = l_id_demandeur AND id_utilisateur_repondant = l_id_repondant);

    IF (@l_id_repondant IS NOT NULL AND @l_id_demandeur IS NOT NULL AND @l_relation_existante = 1 AND @l_id_demandeur <> @l_id_repondant) THEN    
        INSERT INTO t_utilisateur_relation (id_utilisateur_demandeur, id_utilisateur_repondant, relation)
        VALUES (@l_id_demandeur, @l_id_repondant, 'refus');
    END IF;
END#

DELIMITER ;
