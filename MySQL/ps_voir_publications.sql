USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_voir_publications;

DELIMITER #

CREATE PROCEDURE ps_voir_publications (IN p_pseudonyme VARCHAR(40))
BEGIN
    DECLARE l_id_utilisateur INT;
         
    SELECT @l_id_utilisateur := id_utilisateur 
    FROM t_utilisateur 
    WHERE pseudonyme = p_pseudonyme;

    SELECT u.pseudonyme, p.texte_publication, p.date_creation
    FROM t_publication p
    JOIN t_utilisateur u ON (p.id_utilisateur = u.id_utilisateur)
    WHERE p.id_utilisateur IN (SELECT id_utilisateur_ami FROM vue_amis WHERE id_utilisateur = @l_id_utilisateur)
    AND p.statut_publication = 'publiee'
    ORDER BY p.date_creation DESC;

END#

DELIMITER ;