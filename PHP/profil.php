<?php
session_start();
include_once('header.php');
include('donne_profil.php');

?>

    <div>
        <h1>Mon profil</h1>
        <table>
            
            <tr>
                <td> <img src="img/mannequin.png" alt="image" width="100" height="100"> </td>
                <td></td>
                <!--EXTRA qu'on pourrait faire mais on va pas le faire MAIS a presenter-->
                <td> <a href="#">Modifier votre avatar</a> </td>
            </tr>
            <tr>
                <th scope="col">Pseudo :
                 <?php
                if(isset($_SESSION['pseudonyme_connecte']) && !empty($_SESSION['pseudonyme_connecte'])) {
                    echo $affiche['pseudonyme'];
                }
                else {
                    echo " Cher visiteur, veuillez vous connecter ou vous inscrire.";
                }

                ?>
                </th>
                <td> <a href="#">Modifier votre pseudo</a></td>
                
                <td> <a href="changer_mdp.php">Modifier votre mot de passe</a></td>
            </tr>
            <tr>
                <td>Compte : </td>
                <td><?= $affiche['pouvoir'];?></td>
                <td><a href="#">Changer la confidentialité</a></td>
            </tr>
        </table>
    </div>

    <div>
        <h1>Mes Publications</h1>
        <table>
            <?php
                include('publication_profil.php');
            ?>
            <tr>
                <!--
                Ca marche pas ca aucune publication s'affiche 
                -->
                <td><?= $affiche['date_creation']?></td>
                <td><?= $affiche['texte_publication']?></td>
            <tr>
        </table>
    </div>
</body>
</html>