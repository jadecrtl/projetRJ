<?php
    if (!isset($_SESSION)) {
        session_start();
    }
    if (isset($_POST['retirer']) && $_POST['retirer'] == 'Retirer') {
        include('bdd.php');
        $requete = "CALL ps_retirer_de_mes_amis('".$_POST['pseudonyme_a_retirer']."', '".$_SESSION['pseudonyme_connecte']."')";
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



