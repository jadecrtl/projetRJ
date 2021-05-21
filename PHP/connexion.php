<?php
session_start();
?>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Connexion</title>
    <link rel="stylesheet" href="css/mode-up.css" />
</head>

<body>
    <div class="oui">
        <div>
            <img src="img/logo.png" alt="image">
        </div>
        <div>
            <form action="connexion_verification.php" method="post">
                Adresse mail<input type="text" name="saisie_adresse_mail" value=""></br>
                Mot de passe<input type="password" name="saisie_mot_de_passe" value=""></br>
                <input type="submit" name="connexion" value="Connexion"></br>
            </form>
        </div>
        <div>
            </br>
            Si vous n'avez pas de compte <a href="inscription.php">Inscription</a>
            </br>
            Sinon naviguez en tant que <a href="accueil.php">visiteur</a>
        </div>
    </div>
</body>

</html>