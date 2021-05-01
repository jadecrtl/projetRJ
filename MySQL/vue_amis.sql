USE ProjetRJ;

DROP VIEW IF EXISTS vue_amis;


CREATE VIEW vue_amis AS 
    SELECT r.id_utilisateur_demandeur id_utilisateur, r.id_utilisateur_repondant id_utilisateur_ami, u.pseudonyme
    FROM t_utilisateur_relation r, t_utilisateur u
    WHERE r.relation = 'ami'
    AND r.id_utilisateur_repondant = u.id_utilisateur
    UNION
    SELECT r.id_utilisateur_repondant id_utilisateur, r.id_utilisateur_demandeur id_utilisateur_ami, u.pseudonyme
    FROM t_utilisateur_relation r, t_utilisateur u
    WHERE r.relation = 'ami'
    AND r.id_utilisateur_demandeur = u.id_utilisateur;
