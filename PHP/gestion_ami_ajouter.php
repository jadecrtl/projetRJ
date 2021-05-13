<?php
    if (!isset($_SESSION)) {
        session_start();
    }
    if (isset($_POST['ajouter']) && $_POST['ajouter'] == 'Ajouter') {
        include('bdd.php');
        $requete = "CALL ps_ajouter_ami('".$_SESSION['pseudonyme_connecte']."', '".$_POST['pseudonyme_a_ajouter']."')";
        echo $requete;
        $resultat = mysqli_query($connexion, $requete);
        if (!$resultat) {
            echo mysqli_error($connexion);
            echo "Retour à la page d'<a href=\"accueil.php\">accueil</a>";
            exit();
        }
        else {
            mysqli_close($connexion);
            header("location: accueil_recherche_ami.php");
            exit();
        }
    }
    else {
        echo "Vous n'avez rien à faire ici.";
        echo "Retourner à la page d'<a href=\"accueil.php\">accueil</a>";
        exit();
    }



?>