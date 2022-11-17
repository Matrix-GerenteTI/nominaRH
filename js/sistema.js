function checaPermiso(modulo,tipo){
    $.post("ajax/ajaxempleado.php?op=checaPermiso", "modulo="+modulo+"&tipo="+tipo, function(resp){
        console.log(resp)
        if(resp==1)
            return true;
        else
            return false;
    });
}