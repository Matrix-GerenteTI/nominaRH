<?php
	require_once("ajax/control.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<?php require_once('partials/header.php') ?>

</head>
<body class="sidebar-<?=$_SESSION['template']?>">

	<div class="main-wrapper">

		<!-- partial:partials/_sidebar.html -->
	<?php require_once('partials/sidebar.php') ?>
    
		<!-- partial -->
	
		<div class="page-wrapper">
					
			<!-- partial:partials/_navbar.html -->
			<?php require_once('partials/navbar.php') ?>
			<!-- partial -->

	<div class="page-content">
    <div style="display: flex; justify-content: center">
      <img src="/nomina/assets/images/<?=$_SESSION['rfc']?>.jpg" class="img-fluid">
    </div>
      
	</div>
  <?php require_once('partials/js.php') ?>
	<!-- End custom js for this page -->
</body>
</html> 