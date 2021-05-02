
<?php
include('header.php');
?>

<h1>Bienvenuuuuueee
<?php
  if(isset($_SESSION['pseudonyme_connecte']) && !empty($_SESSION['pseudonyme_connecte'])) {
    echo " ".$_SESSION['pseudonyme_connecte'];
  }
  else {
    echo " cher visiteur, vous pouvez vous connecter ou vous inscrire.";
  }
?>

</h1>  
<?php
  include('fil_publications.php');
?>




<div>
  <!--INSERTION DE PUBLICATION-->
</div>







