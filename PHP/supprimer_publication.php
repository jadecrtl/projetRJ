<?php
    if (!isset($_SESSION)) {
        session_start();
    }
    if (isset($_POST['supprimer']) && $_POST['supprimer'] == 'Supprimer') {
        include('bdd.php');
        $requete = "CALL ps_supprimer_publication('".$_SESSION['pseudonyme_connecte']."', '')";
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
    else {
        echo "Vous n'avez rien à faire ici.";
        echo "Retourner à la page d'<a href=\"accueil.php\">acceuil</a>";
        exit();
    }

?>



