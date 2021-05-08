<?php
    if (!isset($_SESSION)) {
        session_start();
    }
    include('bdd.php');
?>
    <?php
    ?>
    <div>
        <h1>Mon profil</h1>
        <table>
            
            <tr>
                <td> <img src="img/avatar.png" alt="image" width="100" height="100"> </td>
                <td></td>
                <!--EXTRA qu'on pourrait faire mais on va pas le faire MAIS a presenter-->
                <td> <a href="#">Modifier votre avatar</a> </td>
            </tr>
            <tr>
                <th scope="col">Pseudo :
                <?php
                if (isset($_SESSION['pseudonyme_connecte']) && !empty($_SESSION['pseudonyme_connecte'])) {
                    $requete = "CALL ps_voir_mon_profil('".$_SESSION['pseudonyme_connecte']."')";
                    $resultat = mysqli_query($connexion,$requete);

                    if (!$resultat) {
                        echo mysqli_error($connexion);
                        exit();
                    }
                    if (mysqli_num_rows($resultat) == 1) {
                        $affiche = mysqli_fetch_assoc($resultat);
                        echo $affiche['pseudonyme'];
                    }
                    else {
                        mysqli_free_result($resultat);
                        echo "erreur: profil introuvable ou multiple profil";
                    }
                }
                else {
                    echo " Cher visiteur, veuillez vous connecter ou vous inscrire.";
                }
                ?>
                </th>
                <br/>
                <td> <a href="#">Modifier votre pseudo</a></td>
                <br/>
                <td> <a href="changer_mdp.php">Modifier votre mot de passe</a></td>
            </tr>
            <tr>
                <td>Compte : </td>
                <td>
                <?php
                    echo $affiche['pouvoir'];
                    mysqli_free_result($resultat);
                    mysqli_close($connexion);
                ?>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <h1>Mes Publications</h1>
        <?php
            include('bdd.php');
            if (isset($_SESSION['pseudonyme_connecte']) && !empty($_SESSION['pseudonyme_connecte'])) {
        
                $requete = "CALL ps_voir_publications_profil('".$_SESSION['pseudonyme_connecte']."')";
                $resultat_publications = mysqli_query($connexion,$requete);

                if (!$resultat_publications) {
                    echo mysqli_error($connexion);
                    exit();
                }
        
                $affiche_publications = mysqli_fetch_assoc($resultat_publications);
                while($affiche_publications) {
                    echo "<article>";
                    echo "<h2>".$affiche_publications['pseudonyme']." le ".$affiche_publications['date_creation']."</h2>";
                    echo $affiche_publications['texte_publication'];
                    echo "</article>";
                    $affiche_publications = mysqli_fetch_assoc($resultat_publications);
                }
                mysqli_free_result($resultat_publications);
            }
        ?>
    </div>

</body>
</html>


