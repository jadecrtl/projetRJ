<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Creation publication</title>
    <link rel="stylesheet" href="css/style.css" />
</head>

<body>
    <div class="publication">
        <h1>Nouvelle publication sur mode-up</h1>
        <form action="creer_publication_verification.php" method="POST">
            <textarea name="publication" rows="5" cols="40" placeholder="Vous pouvez écrire ici."></textarea>
            <input type="submit" name="publier" value="Publier">
            <input type="submit" name="annuler" value="Annuler">
        </form>
    </div>
</body>

</html>