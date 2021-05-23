<html>

<head>
    <meta charset="UTF-8">
    <title>Changer de mot de passe</title>
    <link rel="stylesheet" href="css/style.css" />
</head>

<body>
    <div class="blocPrincipal">
        <?php
        if (!isset($_SESSION)) {
            session_start();
        }
        if (isset($_SESSION['pseudonyme_connecte']) && !empty($_SESSION['pseudonyme_connecte'])) {
            echo "<h1>Changement du mot de passe pour " . $_SESSION['pseudonyme_connecte'] . "</h1>";
        } else {
            echo "Erreur : vous n'êtes pas connecté.</br>";
            echo "Retourner à la page d'<a href=\"accueil.php\">accueil</a>";
            exit();
        }
        ?>
        <form action="changer_mdp_verification.php" method="POST">

            <input type="password" name="mdp_nouveau" placeholder="Nouveau mot de passe"></input><br />
            <input type="password" name="mdp_nouveau_confirm" placeholder="Confirmation mot de passe"></input><br />
            <input type="submit" name="changer_mdp" value="Modifier le mot de passe"></input><br />
            <p>Retourner à la page d'<a href="accueil.php">accueil</a></p>
        </form>
    </div>
</body>

</html>