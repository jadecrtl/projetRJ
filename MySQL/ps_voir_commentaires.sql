USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_voir_commentaires

DELIMITER #

CREATE PROCEDURE ps_voir_commentaires (IN p_pseudonyme VARCHAR(40), IN p_texte_commentaire TEXT)
BEGIN
    DECLARE l_id_utilisateur INT;
    DECLARE l_id_publication INT;
    DECLARE l_id_commentaire INT;

    SELECT @l_id_utilisateur := id_utilisateur 
    FROM t_utilisateur 
    WHERE pseudonyme = p_pseudonyme;

    SELECT @l_id_publication := id_publication
    FROM t_publication
    WHERE id_publication = p_id_publication;

    SELECT @l_id_commentaire := l_id_commentaire
    FROM t_commentaire
    WHERE texte_commentaire = p_texte_commentaire;




END#

DELIMITER ;