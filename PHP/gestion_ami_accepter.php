<?php
    if (!isset($_SESSION)) {
        session_start();
    }
    if (isset($_POST['accepter']) && $_POST['accepter'] == 'Accepter') {
        include('bdd.php');
        $requete = "CALL ps_creer_acceptation_ami('".$_POST['pseudonyme_a_accepter']."', '".$_SESSION['pseudonyme_connecte']."')";
        echo $requete;
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