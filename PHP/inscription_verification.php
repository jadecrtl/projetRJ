<?php

/**
 * 1. Vérifier les données POST transmises ($saisie_pseudonyme + $saisie_adresse_mail + $saisie_mdp1 + $saisie_mdp2 )
 * 2. Connexion à la base de données
 * 3. insertion du nouveau compte dans la table 
 * 4. retour à la page de connexion
 */
    session_start();
    if (isset($_POST['inscription']) && $_POST['inscription'] == 'Inscription') {
        if (
            (isset($_POST['saisie_pseudonyme']) && !empty($_POST['saisie_pseudonyme'])) &&
            (isset($_POST['saisie_mdp1']) && !empty($_POST['saisie_mdp1'])) &&
            (isset($_POST['saisie_mdp2']) && !empty($_POST['saisie_mdp2'])) &&
            ($_POST['saisie_mdp2'] == $_POST['saisie_mdp1']) &&
            (filter_var($_POST['saisie_adresse_mail'], FILTER_VALIDATE_EMAIL))
        ) {
            include ("bdd.php");
            $saisie_pseudonyme = $_POST['saisie_pseudonyme'];
            $saisie_adresse_mail = $_POST['saisie_adresse_mail'];
            $mdp_crypte = password_hash($_POST['saisie_mdp1'], PASSWORD_DEFAULT);
            $requete_sql = " INSERT INTO t_utilisateur (pseudonyme, adresse_mail, mot_de_passe, pouvoir) VALUES ('$saisie_pseudonyme','$saisie_adresse_mail','$mdp_crypte','prive') ";
            $reponse_sql = $bdd->query($requete_sql);
            echo "Votre compte a bien été crée en tant que ".$_POST['saisie_pseudonyme']."</br>";
            echo "Retourner à la page de <a href=\"connexion.php\">Connexion</a>";
            exit();
        }
        else {
            echo "Erreur les données doivent toute être renseignées et les mots de passe doivent être identiques.</br>";
            echo "Retourner à la page d'<a href=\"inscription.php\">Inscription</a>";
            exit();
        }
    }
    else {
        echo "Erreur de provenance : on ne vient pas de la page Inscription.</br>";
        echo "Retourner à la page d'<a href=\"inscription.php\">Inscription</a>";
        exit();
    }


?>
