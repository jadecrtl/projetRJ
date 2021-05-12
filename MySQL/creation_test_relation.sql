USE ProjetRJ;

CALL ps_creer_abonnement('jade1', 'influe1');
CALL ps_creer_abonnement('jade2', 'influe1');
CALL ps_creer_abonnement('jade2', 'influe2');
CALL ps_creer_abonnement('influe1', 'influe3');
CALL ps_creer_abonnement('influe1', 'influe2');
CALL ps_creer_demande_ami('jade3', 'jade1');
CALL ps_creer_abonnement('jade3', 'influe2');
CALL ps_creer_abonnement('jade3', 'influe1');
CALL ps_creer_demande_ami('influe1', 'rayana1');
CALL ps_creer_demande_ami('influe1', 'rayana2');
