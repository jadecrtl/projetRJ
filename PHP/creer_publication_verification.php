<?php
    if (!isset($_SESSION)) {
        session_start();
    }

    if (isset($_POST['publier']) && $_POST['publier'] == 'Publier') {
        if (!isset($_POST['publication']) || empty($_POST['publication'])) {
            echo "La publication ne peut pas être vide.";
            echo "Retourner à la page d'<a href=\"accueil.php\">acceuil</a>";
            exit();
        }
        include('bdd.php');
        $requete = "CALL ps_creer_publication('".$_SESSION['pseudonyme_connecte']."', '".$_POST['publication']."')";
        $resultat = mysqli_query($connexion, $requete);
        if (!$resultat) {
            echo mysqli_error($connexion);
            echo "Retourner à la page d'<a href=\"accueil.php\">acceuil</a>";
            exit();    
        }
        else {
            mysqli_close($connexion);
            header("location: accueil_profil.php");
            exit();
        }
    }

    if (isset($_POST['annuler']) && $_POST['annuler'] == 'Annuler') {
        header("location: accueil.php");
        exit();
    }

    echo "Vous n'avez rien à faire ici.";
    echo "Retourner à la page d'<a href=\"accueil.php\">acceuil</a>";
    exit();

?>