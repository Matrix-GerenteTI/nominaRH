<?php
	require_once("ajax/control.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<?php require_once('partials/header.php') ?>
    <link rel="stylesheet" href="assets/vendors/datatables.net-bs5/dataTables.bootstrap5.css">
</head>
<body class="sidebar-<?=$_SESSION['template']?>">
	<!-- MODAL -->
	<div class="modal fade" id="modalQuery" tabindex="-1" aria-labelledby="modalQueryLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="modalQueryLabel"></h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="btn-close"></button>
			</div>
				<div class="modal-body">
					<div class="container-fluid">
						<div class="row">
							<div class="col-md-12" id="txtQuery">
								

							</div>
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
                                <div class="col-md-8">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            Usuario<br/>
                                            <select id="bususuario" class="form-control"></select>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-4">
                                            Modulo<br/>
                                            <select id="busmodulo" class="form-control"></select>
                                        </div>
                                        <div class="col-lg-4">
                                            De<br/>
                                            <div class="input-group" data-target-input="nearest">
                                                <input type="text" id="fecIni" class="form-control" data-target="#fecIni" autocomplete="off" />
                                                <button class="input-group-text" data-target="#fecIni"><i class="link-icon" data-feather="calendar"></i></button>
                                            </div>
                                        </div>
                                        <div class="col-lg-4">
                                            Al<br/>
                                            <div class="input-group" data-target-input="nearest">
                                                <input type="text" id="fecFin" class="form-control" data-target="#fecFin" autocomplete="off" />
                                                <button class="input-group-text" data-target="#fecFin"><i class="link-icon" data-feather="calendar"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="row">        
                                        <div class="col-md-4">
                                            <div class="d-grid gap-2" style="padding:1em">
                                                <?php if($_SESSION['permisos'][9]['ver']==1){ ?>
                                                <button type="button" class="btn btn-inverse-dark" onclick="lista()"><i data-feather="eye"></i></button>
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
                                        <th> Usuario </th>
                                        <th> Modulo </th>
                                        <th> Fecha </th>
                                        <th> Hora </th>
                                        <th> Movimiento </th>
                                        <th> Query </th>
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
	<script type="text/javascript" src="js/bitacora.js"></script>
</body>
</html>    