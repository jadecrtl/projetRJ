<?php
    if (!isset($_SESSION)) {
        session_start();
    }
    if (isset($_POST['refuser']) && $_POST['refuser'] == 'Refuser') {
        include('bdd.php');
        $requete = "CALL ps_supprimer_demande_ami('".$_POST['pseudonyme_a_refuser']."', '".$_SESSION['pseudonyme_connecte']."')";
        $resultat = mysqli_query($connexion, $requete);
        if (!$resultat) {
            echo mysqli_error($connexion);
            echo "Retourner à la page d'<a href=\"accueil.php\">acceuil</a>";
            exit();    
        }
        else {
            mysqli_close($connexion);
            header("location: accueil_gestion_ami.php");
            exit();
        }
    }
    else {
        echo "Vous n'avez rien à faire ici.";
        echo "Retourner à la page d'<a href=\"accueil.php\">acceuil</a>";
        exit();
    }

?>



