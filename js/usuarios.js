$(document).ready(function(e) {
    nuevo();	    
});
  
function lista(){
    $.post("ajax/ajaxusuarios.php?op=lista", "", function(resp){
          var row = eval('('+resp+')');
        var echo = "";
        for(i in row){
            echo+= "<tr style='cursor:pointer' onClick='cargar(\""+row[i].username+"\")'>";
            echo+= "	<td>"+row[i].username+"</td><td>"+row[i].nombre+"</td><td>"+row[i].grupo+"</td>";
            echo+= "<tr>";
        }
        $("#tbody").html(echo);
    });
}

function cmbTipo(){
$.post("ajax/ajaxusuarios.php?op=cmbTipo", "", function(resp){
        $("#grupo").html(resp);
    });
}

function nuevo(){
    $("#usuario").val('');
    $("#password1").val('');
    $("#password2").val('');
    $("#nombre").val('');	
    $("#email").val('');
    $("#usuario").removeClass('bordeRojo');
    $("#nombre").removeClass('bordeRojo');
    $("#password1").removeClass('bordeRojo');
    $("#password2").removeClass('bordeRojo');
    cmbTipo();
    lista();
}

function cargar(id){
    $.post("ajax/ajaxusuarios.php?op=cargar", "id="+id, function(resp){
        var row = eval('('+resp+')');
        $("#usuario").val(row.username);
        $("#password1").val(row.password);
        $("#password2").val(row.password);
        $("#grupo").val(row.tipo);
        $("#empresa").val(row.idempresa);
        $("#nombre").val(row.nombre);	
        $("#email").val(row.email);
    });
}

function guardar(){
    var campos = new Array('usuario_txt','password1_txt','password2_txt','nombre_txt');
    var validacion = validar(campos);
                    
    if(validacion == true){
        if(validaPass()){
            var params = "username="+$("#usuario").val();
            params+= "&password="+$("#password1").val();
            params+= "&tipo="+$("#grupo").val();
            params+= "&nombre="+$("#nombre").val();
            params+= "&email="+$("#email").val();
            params+= "&idempresa="+$("#empresa").val();
            $.post("ajax/ajaxusuarios.php?op=guardar", params, function(resp){
                if(resp==1){
                    okMsg('Listo!',"El registro se guardo exitosamente!");
                    nuevo();
                }else{
                    if(resp==2)
                        errorMsg('Ups!',"El usuario ya existe en otras conexiones, intente con otro");
                    else
                        errorMsg('Ups!',"Ocurrió un error, intente nuevamente. Si el problema persiste contacte a soporte");
                }
            });
        }else
            miniNotify('error',"No coinciden las contraseñas");
    }else{
        if(validaPass())
            miniNotify('error',"Llene los campos requeridos");
        else
            miniNotify('error',"No coinciden las contraseñas");
    }
}

function eliminar(){
    var username = $("#usuario").val();
    var params = "username="+username;
    $.post("ajax/ajaxusuarios.php?op=eliminar", params, function(resp){
        if(resp<2){
            if(resp==1)
                errorMsg('Ups!',"Ocurrió un error, intente nuevamente. Si el problema persiste contacte a soporte");
        }else{
            okMsg('Listo!',"El usuario se elimino exitosamente!");
            nuevo();
        }
    });	
}

function validaPass(){
    var pass1 = $("#password1").val();
    var pass2 = $("#password2").val();
    if(pass1!=pass2){
        $("#password2").addClass('bordeRojo');
        return false;
    }else{
        $("#password2").removeClass('bordeRojo');
        return true;
    }
}

function validar(campos){
    var res = true;
    for(a in campos){
        var arr = campos[a].split("_");
        //alert(arr[1]);
        if(arr[1] == "txt"){
            var campo = $("#"+arr[0]).val();
            if(campo==""){
                 $("#"+arr[0]).addClass('bordeRojo');
                 res = false;
            }else{
                 $("#"+arr[0]).removeClass('bordeRojo');
            }
        }
    }
    return res;
}