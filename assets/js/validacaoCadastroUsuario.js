// seleciona o formulário
const formCadastro = document.querySelector('form');
const imgErro = "/assets/img/icones/erro.svg"
//const URL = "http://127.0.0.1:5500/assets/pages/pagina_sucesso_cadastro.html"

let mensagemErro = [
    {
        campoVazio:{
            nome: `<span class="error-message"><img src="${imgErro}"> Por favor, preencha o nome!</span>`,
            email: `<span class="error-message"><img src="${imgErro}"> Por favor, preencha o email!</span>`,
            dataNascimento: `<span class="error-message"><img src="${imgErro}"> Por favor, preencha a data de nascimento!</span>`,
            telefone: `<span class="error-message"><img src="${imgErro}"> Por favor, preencha o telefone!</span>`,
            senha: `<span class="error-message"><img src="${imgErro}"> Por favor, preencha a senha!</span>`,
            confirmaSenha: `<span class="error-message"><img src="${imgErro}"> Por favor, preencha a confirmação de senha!</span>`
        },
        senhaDiferente:`<span class="error-message"><img src="${imgErro}"> As senhas não coincidem!</span>`,
        verificaIdade: {
            valida: `<span class="error-message"><img src="${imgErro}"> Por favor, insira uma data de nascimento válida!</span>`,
            menorOuMaiorDeIade: `<span class="error-message"><img src="${imgErro}"> Você precisa ter mais de 18 anos para se cadastrar!</span>`
        }
    }
]

// adiciona um evento de submit ao formulário
formCadastro.addEventListener('submit', (event) => {
    event.preventDefault(); // impede que o formulário seja enviado

    // seleciona os campos de entrada
    const inputNome = document.getElementById('nome');
    const inputEmail = document.getElementById('email');
    const inputDataNascimento = document.getElementById('dataNascimento');
    const inputTelefone = document.getElementById('telefone');
    const inputSenha = document.getElementById('senha');
    const inputConfirmarSenha = document.getElementById('confirmarSenha');

    // verifica se os campos estão preenchidos
    if (!validaCampos(inputNome, inputEmail, inputDataNascimento, inputTelefone, inputSenha, inputConfirmarSenha)) {
        return;
    }

    if(!validaDataNascimento(inputDataNascimento)){
        return;
    }
    // verifica se as senhas coincidem
    if (!validaSenha(inputSenha, inputConfirmarSenha)) {
        return;
    }
    // envia o formulário
    formCadastro.submit()
});

function validaCampos(inputNome, inputEmail, inputDataNascimento, inputTelefone, inputSenha, inputConfirmarSenha) {
    let valid = true;
    if (inputNome.value.trim() === '') {
        inputNome.insertAdjacentHTML('afterend', mensagemErro[0]['campoVazio']['nome']);
        valid = false;
    }
    if (inputEmail.value.trim() === '') {
        inputEmail.insertAdjacentHTML('afterend', mensagemErro[0]['campoVazio']['email']);
        valid = false;
    }
    if (inputDataNascimento.value.trim() === '') {
        inputDataNascimento.insertAdjacentHTML('afterend', mensagemErro[0]['campoVazio']['dataNascimento']);
        valid = false;
    }

    if (inputTelefone.value.trim() === '') {
        inputTelefone.insertAdjacentHTML('afterend', mensagemErro[0]['campoVazio']['telefone']);
        valid = false;
    }
    if (inputSenha.value.trim() === '') {
        inputSenha.insertAdjacentHTML('afterend', mensagemErro[0]['campoVazio']['senha']);
        valid = false;
    }
    if (inputConfirmarSenha.value.trim() === '') {
        inputConfirmarSenha.insertAdjacentHTML('afterend', mensagemErro[0]['campoVazio']['confirmaSenha']);
        valid = false;
    }
    return valid;
}

function validaDataNascimento(inputDataNascimento) { 
    // converte a data de string para objeto Date
    const dataNascimento = new Date(inputDataNascimento.value);
    
    // seleciona o elemento irmão imediatamente após o elemento de entrada de data de nascimento
    const inputDataNascimentoWrapper = inputDataNascimento.parentNode;
    const inputDataNascimentoErrorMessage = inputDataNascimentoWrapper.querySelector('.error-message');

    // remove a mensagem de erro anterior, se houver
    if (inputDataNascimentoErrorMessage) {
        inputDataNascimentoErrorMessage.remove();
    }
    
    // verifica se a data de nascimento é válida
    if (isNaN(dataNascimento.getTime())) {
      inputDataNascimentoWrapper.insertAdjacentHTML('afterend', mensagemErro[0]['verificaIdade']['menorOuMaiorDeIade']);
      return false;
    }
    
    // verifica se a idade é maior que 18 anos
    let hoje = new Date();
    let idade = hoje.getFullYear() - dataNascimento.getFullYear();
    let mes = hoje.getMonth() - dataNascimento.getMonth();
    
    if (mes < 0 || (mes === 0 && hoje.getDate() < dataNascimento.getDate())) {
      idade--;
    }
    
    if (idade < 18) {
      inputDataNascimentoWrapper.insertAdjacentHTML('afterend', mensagemErro[0]['verificaIdade']['valida']);
      return false;
    }
    
    // retorna verdadeiro se todas as validações passaram
    return true;
}
  
function validaSenha(inputSenha, inputConfirmarSenha) {
    if (inputSenha.value !== inputConfirmarSenha.value) {
        inputConfirmarSenha.insertAdjacentHTML('afterend', mensagemErro[1]['senhaDiferente']);
        return false;
    }
    return true;
}