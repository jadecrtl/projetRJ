<?php
if (!isset($_SESSION)) {
    session_start();
}
?>
<div>
    <h1>Mon profil</h1>
    <article id="profil_avatar">
        <p><img src="img/avatar.png" alt="image"></p>
        <p><a href="#">Modifier votre avatar (non fonctionnel)</a></p>
    </article>

    <article id="profil_information">

        <?php
        include('bdd.php');
        if (isset($_SESSION['pseudonyme_connecte']) && !empty($_SESSION['pseudonyme_connecte'])) {
            $requete = "CALL ps_voir_mon_profil('" . $_SESSION['pseudonyme_connecte'] . "')";
            $resultat = mysqli_query($connexion, $requete);

            if (!$resultat) {
                echo mysqli_error($connexion);
                exit();
            }
            if (mysqli_num_rows($resultat) == 1) {
                $affiche = mysqli_fetch_assoc($resultat);
                echo "<p>Pseudo: " . $affiche['pseudonyme'] . "</p>";
                echo "<p>Adresse: " . $affiche['adresse_mail'] . "</p>";
                echo "<p>Pouvoir: " . $affiche['pouvoir'] . "</p>";
            } else {
                mysqli_free_result($resultat);
                echo "erreur: profil introuvable ou multiple profil";
            }
        } else {
            echo " Cher visiteur, veuillez vous connecter ou vous inscrire.";
        }
        ?>
        <p><a href="#">Modifier votre pseudo (non fonctionnel)</a></p>
        <p><a href="changer_mdp.php">Modifier votre mot de passe</a></p>

    </article>
</div>
<div>
    <h1> Mes Abonnées </h1>
    <article>
    <?php
        include('bdd.php');
        if (isset($_SESSION['pseudonyme_connecte']) && !empty($_SESSION['pseudonyme_connecte'])) {
            $requete = "CALL ps_voir_nombre_amis('" . $_SESSION['pseudonyme_connecte'] . "')";
            $resultat = mysqli_query($connexion, $requete);

            if (!$resultat) {
                echo mysqli_error($connexion);
                exit();
            }
            if (mysqli_num_rows($resultat) == 1) {
                $affiche = mysqli_fetch_assoc($resultat);
                echo "<p>Abonnée: " . $affiche['nb_abonnee'] . "</p>";
            } else {
                mysqli_free_result($resultat);
                echo "erreur: profil introuvable ou multiple profil";
            }
        } else {
            echo " Cher visiteur, veuillez vous connecter ou vous inscrire.";
        }
        ?> 
    </article>
</div>
<div>
    <h1>Mes Publications</h1>
    <?php
    include('bdd.php');
    if (isset($_SESSION['pseudonyme_connecte']) && !empty($_SESSION['pseudonyme_connecte'])) {

        $requete = "CALL ps_voir_publications_profil('" . $_SESSION['pseudonyme_connecte'] . "')";
        $resultat_publications = mysqli_query($connexion, $requete);

        if (!$resultat_publications) {
            echo mysqli_error($connexion);
            exit();
        }

        $affiche_publications = mysqli_fetch_assoc($resultat_publications);
        if (mysqli_num_rows($resultat_publications) == 0) {
            echo "Aucune publication.";
        }
        while ($affiche_publications) {
            $affiche_publications['texte_publication'] = str_replace("\\r","\r",$affiche_publications['texte_publication']);
            $affiche_publications['texte_publication'] = str_replace("\\n","\n",$affiche_publications['texte_publication']);
            echo "<article>";
            echo "<h2>" . $affiche_publications['pseudonyme'] . " le " . $affiche_publications['date_creation'] . "</h2>";
            echo nl2br($affiche_publications['texte_publication']);
            echo "</article>";
            echo "<form action=\"supprimer_publication.php\" method=\"POST\" class=\"form formsup\">";
            echo "<input type=\"submit\" name=\"supprimer\" value=\"Supprimer\">";
            echo "<input type=\"hidden\" name=\"id_de_publication\" value=".$affiche_publications['id_publication'].">";
            echo "</form>";
            $affiche_publications = mysqli_fetch_assoc($resultat_publications);
        }
        mysqli_free_result($resultat_publications);
        mysqli_close($connexion);
    }
    ?>
</div>