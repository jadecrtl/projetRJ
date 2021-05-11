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
<html>

<head>
    <meta charset="UTF-8">
    <title>Changer de mot de passe</title>
</head>

<body>
    <form action="changer_mdp_verification.php" method="POST">

        <label>Nouveau mot de passe :</label>
        <input type="password" name="mdp_nouveau"></input><br />


        <label>Confirmation mot de passe :</label>
        <input type="password" name="mdp_nouveau_confirm"></input><br />

        <input type="submit" name="changer_mdp" value="Modifier le mot de passe"></input><br />
        <p>Retourner à la page d'<a href="accueil.php">accueil</a></p>
    </form>
</body>

</html>