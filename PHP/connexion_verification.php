<?php

/**
 * 1. Vérifier les données POST transmises ($username + $password)
 * 2. Connexion à la base de données
 * 3. Récupérer depuis la table user de la BDD le $hash ($password haché) du $username et vérifier l'existence de l'utilisateur
 * 4. Vérifier la correspondance entre le $password et le $hash
 * 5. Créer la SESSION['user']
 */
    session_start();
    if (isset($_POST['connexion']) && $_POST['connexion'] == 'Connexion') {
        if (
            (isset($_POST['saisie_adresse_mail']) && !empty($_POST['saisie_adresse_mail'])) &&
            (isset($_POST['saisie_mot_de_passe']) && !empty($_POST['saisie_mot_de_passe'])) &&
            (filter_var($_POST['saisie_adresse_mail'], FILTER_VALIDATE_EMAIL))
        ) {
            include ("bdd.php");
            
            $requete_sql = 'CALL ps_voir_fiche_adresse_mail("'.$_POST['saisie_adresse_mail'].'")';
            $reponse_sql = $bdd->query($requete_sql);
            $resultat_requete = $reponse_sql->fetchAll(); //On veut toute les lignes du tableau pour être sur qu'il n'y a qu'un seul résultat
            $resultat_compte = count($resultat_requete);

            if ($resultat_compte == 1) {
                $connexion_valide = password_verify($_POST['saisie_mot_de_passe'], $resultat_requete[0]['mot_de_passe']);
                if ($connexion_valide) {
                    $_SESSION['pseudonyme_connecte'] = $resultat_requete[0]['pseudonyme'];
                    echo "Vous êtes connecté(e) en tant que ".$_SESSION['pseudonyme_connecte']."</br>";
                    echo "Retourner à la page de <a href=\"accueil.php\">accueil</a>";
                    exit();    

                }
                else {
                    echo "Le mot de passe est invalide. Veuillez réessayer à nouveau.";
                    echo " Retourner à la page de <a href=\"connexion.php\">connexion</a> ";
                    exit();    
                }
            }
            else {
                echo "La fiche ne semble pas être unique.</br>";
                echo " Retourner à la page de <a href=\"connexion.php\">connexion</a>";
                exit();
            }

            exit();
        }
        else {
            echo "Erreur de saisie : l'adresse mail ou le mot de passe sont invalides.</br>";
            echo "Retourner à la page de <a href=\"connexion.php\">connexion</a>";
            exit();
        }
    }
    else {
        echo "Erreur de provenance : on ne vient pas de la page connexion.</br>";
        echo "Retourner à la page de <a href=\"connexion.php\">connexion</a>";
        exit();
    }


?>