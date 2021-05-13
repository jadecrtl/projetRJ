USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_voir_nouveaux_amis;

DELIMITER #

CREATE PROCEDURE ps_voir_nouveaux_amis (IN p_pseudonyme VARCHAR(40))
BEGIN

    DECLARE l_id_utilisateur INT;

    SET @l_id_utilisateur = (SELECT id_utilisateur FROM t_utilisateur WHERE pseudonyme = p_pseudonyme);

    SELECT id_utilisateur, pseudonyme
    FROM t_utilisateur
    WHERE id_utilisateur NOT IN
        (
        SELECT r.id_utilisateur_repondant id_utilisateur
        FROM t_utilisateur_relation r, t_utilisateur u
        WHERE r.id_utilisateur_demandeur = @l_id_utilisateur
        AND r.relation IN('ami', 'attente', 'refus')
        AND r.id_utilisateur_repondant = u.id_utilisateur
        UNION
        SELECT r.id_utilisateur_demandeur id_utilisateur
        FROM t_utilisateur_relation r, t_utilisateur u
        WHERE r.id_utilisateur_repondant = @l_id_utilisateur
        AND r.relation IN('ami', 'attente', 'refus')
        AND r.id_utilisateur_demandeur = u.id_utilisateur
        )
    AND id_utilisateur <> @l_id_utilisateur
    ORDER BY pseudonyme ASC;

END#

DELIMITER ;
