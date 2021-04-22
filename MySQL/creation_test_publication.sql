USE ProjetRJ;

DELETE FROM t_publication;

CALL ps_creer_publication('influe1', 'Je suis influe1 et bienvenu sur mon premier post!');
CALL ps_creer_publication('influe1', 'En visualisant mon mur de publications je vous présenterai au fur et à mesure des références modes et makeup.');
CALL ps_creer_publication('influe2', 'Hey je suis influe2 je suis nouveau sur ce réseau.');
CALL ps_creer_publication('jade1', 'J''aime beaucoup le maquillage!');
CALL ps_creer_publication('jade2', 'Une boutique à me conseiller pour un style rock sur Paris?');
CALL ps_creer_publication('jade2', 'J''ai trouvé une boutique super sympa elle s''appelle & other stories je vous la conseille!');
CALL ps_creer_publication('jade2', 'Vivement que le confinement se finisse on en peut plus!');
