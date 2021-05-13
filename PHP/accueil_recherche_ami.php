<?php
if (!isset($_SESSION)) {
	session_start();
}
?>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8" />
	<title>Rechercher amis</title>
	<link rel="stylesheet" href="mode-up.css" />
</head>

<body>
	<header><?php include('header.php'); ?></header>
	<div><?php include('recherche_ami.php'); ?></div>
</body>

</html>