<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
</body>

</html>

<?php
$name_server = 'localhost';
$user = 'root';
$senha = '';
$banco = 'db_taskflow';

$mensagemError = [
    'conexao' => "Conexão falhou: " . $conecta->connect_error . "<br>",
    'createDB' => 'Erro na criação do banco de dados ' . $conecta->error . "<br>",
    'createTable' => 'Erro ao criar a tabela' . $conecta->error . '<br>'
];

$mensagemDeSucesso = [
    'conexao' => "conexao realizado com sucesso!<br>",
    'createDB' => "O db_taskflow_teste foi criado com sucesso!<br>",
    'createTable' => 'A tabela foi criada com sucesso'
];

$conecta = new mysqli($name_server, $user, $senha,$banco);
//Verifica conexão
if ($conecta->connect_error) {
    die($mensagemError['conexao']);
} else {
    echo $mensagemDeSucesso['conexao'];
}


/*if($conecta->query($sql) === TRUE)
    echo $mensagemDeSucesso['createTable'];
else
    echo $mensagemError['createTable'];*/

$conecta->close();
