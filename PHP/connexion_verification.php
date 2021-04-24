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
            echo "Succés!";
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