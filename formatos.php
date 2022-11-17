<?php
	require_once("ajax/control.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<?php require_once('partials/header.php') ?>
	<link rel="stylesheet" href="assets/vendors/simplemde/simplemde.min.css">
</head>
<body class="sidebar-<?=$_SESSION['template']?>">

<div class="main-wrapper">

    <!-- partial:partials/_sidebar.html -->
    <?php require_once('partials/sidebar.php') ?>
		<div class="page-wrapper">
					
			<!-- partial:partials/_navbar.html -->
			<?php require_once('partials/navbar.php') ?>
			<!-- partial -->
		<div class="page-content">
            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header" style="font-size:1.2em; font-weight:bold"> 
                            <i class="icon-edit"></i> <span>Formatos del sistema</span>
                        </div>
                        <!-- /widget-header -->
                        <div class="card-body" style="padding:10px">
                            <div class="row">
                                <div class="col-8">
                                    Formato:<br/>
                                    <select id="formato" name="formato" class="form-control"></select>
                                </div>
                                <div class="col-4">
                                    <br/>
                                    <?php if($_SESSION['permisos'][19]['ver']==1){ ?>
									<button class="btn btn-info btn-icon" onclick="cargar()"><i class="mdi mdi-eye"></i></button>
									<?php } ?>
                                    <?php if($_SESSION['permisos'][19]['guardar']==1){ ?>
									<button class="btn btn-success btn-icon" onclick="guardarFormato()"><i class="mdi mdi-content-save"></i></button>
									<?php } ?>
                                </div> 
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <div class="card-body">
                                        <div id="badges"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <textarea class="form-control" name="editor" id="editor" rows="25"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <!-- /span6 -->
            </div>
		</div>
	</div>

	<?php require_once('partials/js.php') ?>
	<!-- End custom js for this page -->
	<script src="assets/vendors/tinymce/tinymce.min.js"></script>
	<script type="text/javascript" src="js/formatos.js"></script>
	<script src="assets/js/tinymce.js"></script>
</body>
</html>    