USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_voir_publications_visiteur;

DELIMITER #

CREATE PROCEDURE ps_voir_publications_visiteur ()
BEGIN

    SELECT u.pseudonyme, p.texte_publication, p.date_creation
    FROM t_publication p
    JOIN t_utilisateur u ON (u.id_utilisateur = p.id_utilisateur)
    WHERE u.pouvoir = 'public'
    AND p.statut_publication = 'publiee'
    ORDER BY p.date_creation DESC;

END#

DELIMITER ;