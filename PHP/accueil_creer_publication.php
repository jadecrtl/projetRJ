<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Creation publication</title>
</head>

<body>
    <h1>Nouvelle publication sur mode-up</h1>
    <form action="creer_publication_verification.php" method="POST">
        <textarea name="publication" rows="5" cols="40" placeholder="Vous pouvez écrire ici."></textarea>
    </form>
    <form action="publication_publiee.php" method="POST">
        <input type="submit" name="publier" value="Publier">
    </form>
    <form action="publication_annuler.php" method="POST">
        <input type="submit" name="annuler" value="Annuler">
    </form>
</body>

</html>