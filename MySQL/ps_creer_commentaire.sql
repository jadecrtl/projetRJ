USE ProjetRJ;

DROP PROCEDURE IF EXISTS ps_creer_commentaire;

DELIMITER #

CREATE PROCEDURE ps_creer_commentaire (IN p_pseudonyme VARCHAR(40), IN p_id_publication INT, IN p_texte_commentaire TEXT)
BEGIN

--le p_pseudonyme est l'utilisateur 
--qui veut écrire un p_texte_commentaire 
--sous la publication qui est représenté par p_id_publication
--vérifions si p_pseudonyme fait parti des utilisateurs
--puis si cet utilisateur est ami avec celui qui a la publication

    DECLARE l_id_commentateur INT;
    DECLARE l_date_commentaire_creation TIMESTAMP;
    DECLARE l_id_publicateur INT;
    DECLARE l_relation_existante INT;
    
    SELECT @l_id_commentateur := id_utilisateur 
    FROM t_utilisateur 
    WHERE pseudonyme = p_pseudonyme;

    SELECT @l_date_commentaire_creation := NOW();

    --verifier que la publication existe et en même temps on récupére son publicateur
    SELECT @l_id_publicateur := id_utilisateur
    FROM t_publication
    WHERE id_publication = p_id_publication;

    --on vérifie que le commentateur et le publicateur son ami
    --dans le cas où c'est 2 comptes privés ou un compte public qui veut commenter un compte privé
    
    SELECT @l_relation_existante := COUNT(*)
    FROM t_utilisateur_relation
    WHERE ((id_utilisateur_demandeur = l_id_commentateur AND id_utilisateur_repondant = l_id_publicateur)
    OR (id_utilisateur_demandeur = l_id_publicateur AND id_utilisateur_repondant = l_id_commentateur))
    AND relation = 'ami';

    IF (@l_id_commentateur IS NOT NULL AND @l_id_publicateur IS NOT NULL AND @l_relation_existante >= 1) THEN
        INSERT INTO t_commentaire (id_publication, id_utilisateur, texte_commentaire, date_commentaire)
        VALUES (@l_id_commentateur, p_id_publication, p_texte_commentaire, @l_date_commentaire_creation);
    END IF;

END#

DELIMITER ;