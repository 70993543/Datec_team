const client = require("../../database/db"),
    db = client.db('DATEC');

let controller = {

    //Listar
    list: function (req, res) {
        console.log('-----------------------------');
        console.log('ENTRANDO A LA FUNCION LISTAR');
        db.collection("televisor").find().toArray(
            (error, dataTelevisor) => {
                if (error || !dataTelevisor) {
                    return res.status(404).send({
                        message: "No se ha encontrado los televisor"
                    });
                } else {
                    return res.status(200).send({
                        status: "success",
                        televisor: dataTelevisor
                    });
                }
            }
        );
    },
    // Buscar
    find: function (req, res) {
        console.log('-----------------------------');
        console.log('ENTRANDO A LA FUNCION BUSCAR');
        db.collection("televisor").find({televisorId: parseInt(req.params.id)}).toArray(
            (error, dataTelevisor) => {
                if (error || !dataTelevisor) {
                    return res.status(404).send({
                        message: "No se encontro el televisor"
                    });
                } else {
                    return res.status(200).send({
                        status: "success",
                        televisor: dataTelevisor[0]
                    });
                }
            }
        );
    },
    // Guardar
    save: function (req, res) {
        console.log('-----------------------------');
        console.log('ENTRANDO A LA FUNCION SAVE');
        console.log(req.body);
        if (req.body.televisorId == "0") {
            db.collection("televisor").estimatedDocumentCount().then(
                countTelevisor => {
                    let televisor = {}
                    televisor.televisorId = countTelevisor + 1;
                    televisor.descripcion = req.body.descripcion;
                    televisor.precio = req.body.precio;
                    televisor.imagen = req.body.imagen;
                    televisor.categoria = req.body.categoria;
                    televisor.estado = req.body.estado;

                    db.collection("televisor").insertOne(
                        televisor, (error, result) => {
                            if (error) {
                                return res.status(404).send({
                                    message: "No se pudo registrar el televisor"
                                });
                            } else {
                                return res.status(200).send({
                                    status: "succes",
                                    televisor: result
                                });
                            }
                        }
                    )
                }
            )
        } else {
            console.log('ENTRANDO A EDITAR');
            let televisor = {}
            televisor.televisorId = parseInt(req.body.televisorId);
            televisor.descripcion = req.body.descripcion;
            televisor.precio = req.body.precio;
            televisor.imagen = req.body.imagen;
            televisor.categoria = req.body.categoria;
            televisor.estado = req.body.estado;
            console.log(televisor);
            db.collection("televisor").updateOne({televisorId: {$eq: parseInt(req.body.televisorId)}},
                                                        {$set: televisor},
                (error, result) =>{
                    if (error){
                        return res.status(404).send({
                            message: "No se pudo editar el televisor"
                        });
                    }else {
                        return res.status(200).send({
                            status: "success",
                            televisor: result
                        });
                    }
                }
            )

        }
    }
}

module.exports = controller;




