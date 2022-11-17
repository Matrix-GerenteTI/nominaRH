<?php
	require_once("ajax/control.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<?php require_once('partials/header.php') ?>
    <link rel="stylesheet" href="assets/vendors/datatables.net-bs5/dataTables.bootstrap5.css">
    <style>
        .bordeRojo{
            border:#F00 1px solid;
        }
    </style>
</head>
<body class="sidebar-<?=$_SESSION['template']?>">
	<!-- MODAL -->
	<div class="modal fade" id="modalIncidencias" tabindex="-1" aria-labelledby="modalIncidenciasLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="modalIncidenciasLabel"></h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="btn-close"></button>
			</div>
				<div class="modal-body">
					<div class="container-fluid">
						<div class="row" id="bodyIncidencias">
						</div>					
					</div>
				</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
			</div>
			</div>
		</div>
	</div>
	<div class="main-wrapper">

		<!-- partial:partials/_sidebar.html -->
		<?php require_once('partials/sidebar.php') ?>
    
		<!-- partial -->
	
		<div class="page-wrapper">
					
			<!-- partial:partials/_navbar.html -->
			<?php require_once('partials/navbar.php') ?>
			<!-- partial -->
		<div class="page-content">
		<div class="row">
                <div class="col-12">
                    <div class="card">
						<div class="card-body" style="padding:10px">
                            <div class="row">
                                <div class="col-md-10">
                                    <div class="row">
                                        <div class="col-lg-4">
                                            UDN<br/>
                                            <select id="busudn" class="form-control"></select>
                                        </div>
                                        <div class="col-lg-4">
                                            Departamento<br/>
                                            <select id="busdepartamento" class="form-control"></select>
                                        </div>
                                        <div class="col-lg-4">
                                            Puesto<br/>
                                            <select id="buspuesto" class="form-control"></select>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-4">
                                            Empelado<br/>
                                            <select id="busempleado" class="form-control"></select>
                                        </div>
                                        <div class="col-lg-4">
                                            De<br/>
                                            <div class="input-group" data-target-input="nearest">
                                                <input type="text" id="fecIni" class="form-control" data-target="#fecIni" autocomplete="off" value="<?php echo date("d/m/Y"); ?>" />
                                                <button class="input-group-text" data-target="#fecIni"><i class="link-icon" data-feather="calendar"></i></button>
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            Al<br/>
                                            <div class="input-group" data-target-input="nearest">
                                                <input type="text" id="fecFin" class="form-control" data-target="#fecFin" autocomplete="off" value="<?php echo date("d/m/Y"); ?>" />
                                                <button class="input-group-text" data-target="#fecFin"><i class="link-icon" data-feather="calendar"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="row">        
                                        <div class="col-md-12">
                                            <div class="d-grid gap-2" style="padding:1em">
                                                <?php if($_SESSION['permisos'][10]['ver']==1){ ?>
                                                <button type="button" class="btn btn-inverse-dark" onclick="verLista()"><i data-feather="eye"></i></button>
                                                <?php } if($_SESSION['permisos'][10]['imprimir']==1){ ?>
                                                <button type="button" class="btn btn-info" onclick="descargar()"><i data-feather="download"></i></button>
                                                <?php } if($_SESSION['permisos'][10]['guardar']==1){ ?>
                                                <button type="button" class="btn btn-success" onclick="guardar()"><i data-feather="save"></i></button>
                                                <?php } ?> 
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <hr/>
                            <div class="table-responsive">
                                <table id="tableData" class="table">
                                    <thead>
                                    <tr>
                                        <th> UDN </th>
                                        <th> Departamento </th>
                                        <th> Puesto </th>
                                        <th> Empleado </th>
                                        <th> Percepciones </th>
                                        <th> Deducciones </th>
                                        <th> ($) Bancos </th>
                                        <th> ($) Efectivo </th>
                                        <th> ($) Vales </th>
                                        <th> ($) Otros </th>
                                        <th> ($) Total </th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- /widget -->
                </div>
            </div>
		</div>
	</div>

	<?php require_once('partials/js.php') ?>
    <script src="assets/vendors/datatables.net/jquery.dataTables.js"></script>
    <script src="assets/vendors/datatables.net-bs5/dataTables.bootstrap5.js"></script>
	<!-- End custom js for this page -->
    <script src="assets/js/data-table.js"></script>
	<script type="text/javascript" src="js/calculo.js"></script>
</body>
</html>    