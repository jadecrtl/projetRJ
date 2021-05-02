USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_creer_abonnement;

DELIMITER #

CREATE PROCEDURE ps_creer_abonnement (IN p_pseudonyme_demandeur VARCHAR(40), IN p_pseudonyme_influenceur VARCHAR(40))
BEGIN
    DECLARE l_id_influenceur INT;
    DECLARE l_id_demandeur INT;
    DECLARE l_relation_existante INT;

    SET @l_id_influenceur = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme_influenceur AND pouvoir = 'public');

    SET @l_id_demandeur = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme_demandeur);

    SET @l_relation_existante = (SELECT COUNT(*) FROM t_utilisateur_relation WHERE id_utilisateur_demandeur = l_id_demandeur AND id_utilisateur_repondant = l_id_influenceur);

    IF (@l_id_influenceur IS NOT NULL AND @l_id_demandeur IS NOT NULL AND @l_relation_existante = 0 AND @l_id_demandeur <> @l_id_influenceur) THEN    
        INSERT INTO t_utilisateur_relation (id_utilisateur_demandeur, id_utilisateur_repondant, relation)
        VALUES (@l_id_demandeur, @l_id_influenceur, 'ami');
    END IF;
END#

DELIMITER ;
