*** Settings ***
Resource    ../resources/api_testing_usuarios.resource

*** Test Cases ***
Cenario 01: Cadastrar um novo usuario com secesso na ServerRest
    Criar um usuário novo
    Cadastrar o usuário criado na ServerRest    email=${EMAIL_TESTE}    status_code_desejado=201
    Conferir se o usuário foi cadastrado corretamente

Cenario 02: Cadastrar um usuário já existente
    Criar um usuário novo
    Cadastrar o usuário criado na ServerRest   email=${EMAIL_TESTE}    status_code_desejado=201
    Vou repetir o cadastro do usuário    
    Verificar se a API não permitiu o cadastrado repetido

Cenario 03: Consultar os dados de um novo usuário
    Criar um usuário novo
    Cadastrar o usuário criado na ServerRest    email=${EMAIL_TESTE}    status_code_desejado=201
    Consultar os dados do novo usuário
    Conferir os dados retornados

Cenario 04: Logar com um novo usuário criado
    Criar um usuário novo
    Cadastrar o usuário criado na ServerRest    email=${EMAIL_TESTE}    status_code_desejado=201
    Realizar Login com o usuário
    Conferir se o Login ocorreu com sucesso
