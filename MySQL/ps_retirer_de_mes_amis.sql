USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_retirer_de_mes_amis;

DELIMITER #

CREATE PROCEDURE ps_retirer_de_mes_amis (IN p_pseudonyme_a_retirer VARCHAR(40), IN p_pseudonyme VARCHAR(40))
BEGIN
    DECLARE l_id_a_retirer INT;
    DECLARE l_id_utilisateur INT;

    SET @l_id_utilisateur = (
        SELECT id_utilisateur 
        FROM t_utilisateur
        WHERE pseudonyme = p_pseudonyme);

    SET @l_id_a_retirer = (
        SELECT id_utilisateur 
        FROM t_utilisateur
        WHERE pseudonyme = p_pseudonyme_a_retirer);

    IF (@l_id_utilisateur IS NOT NULL AND @l_id_a_retirer IS NOT NULL AND @l_id_a_retirer <> @l_id_utilisateur) THEN    
        UPDATE t_utilisateur_relation
        SET relation = 'refus'
        WHERE (id_utilisateur_demandeur = @l_id_a_retirer AND id_utilisateur_repondant = @l_id_utilisateur)
        OR
        (id_utilisateur_demandeur = @l_id_utilisateur AND id_utilisateur_repondant = @l_id_a_retirer);
    END IF;
END#

DELIMITER ;
