*** Settings ***
Library    RequestsLibrary
Library    String
Library    SeleniumLibrary
Library    Collections
Library    OperatingSystem


*** Keywords ***
Criar um usuário novo
    ${palavra_aleatoria}    Generate Random String    length=4    chars=[LETTERS]
    ${palavra_aleatoria}    Convert To Lower Case    ${palavra_aleatoria}
    Log    Minha palavra aleatoria:${palavra_aleatoria}
    Set Test Variable    ${EMAIL_TESTE}    ${palavra_aleatoria}@emailteste.com
    Log    ${EMAIL_TESTE}

Cadastrar o usuário criado na ServerRest
    [Arguments]    ${email}    ${status_code_desejado}
    ${body}    Create Dictionary    
    ...        nome=Fulano da Silva    
    ...        email=${EMAIL_TESTE}    
    ...        password=1234    
    ...        administrador=true
    Log        {body}

    Criar Sessao na ServerRest

    ${resposta}    POST On Session    
    ...            alias=ServerRest
    ...            url=/usuarios
    ...            json=${body}
    ...            expected_status=${status_code_desejado}
    
    Log    ${resposta.json()}
    IF    ${resposta.status_code} == 201
        Set Test Variable    ${ID_USUARIO}    ${resposta.json()["_id"]}
    END

    Set Test Variable    ${RESPOSTA}      ${resposta.json()}

Criar Sessao na ServerRest
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    alias=ServerRest    url=https://serverest.dev    headers=${headers}

Conferir se o usuário foi cadastrado corretamente
    Log    ${RESPOSTA}
    Dictionary Should Contain Item    ${RESPOSTA}    message    Cadastro realizado com sucesso
    Dictionary Should Contain Key    ${RESPOSTA}    _id

Vou repetir o cadastro do usuário
    Cadastrar o usuário criado na ServerRest    ${EMAIL_TESTE}    status_code_desejado=400
    
Verificar se a API não permitiu o cadastrado repetido
    Dictionary Should Contain Item    ${RESPOSTA}    message    Este email já está sendo usado

Consultar os dados do novo usuário
    ${resposta_consulta}    GET On Session    alias=ServerRest    url=/usuarios/${ID_USUARIO}    expected_status=any

    Log    ${resposta_consulta.reason}
    Log    ${resposta_consulta.headers}
    Log    ${resposta_consulta.elapsed}
    Log    ${resposta_consulta.text}

    Set Test Variable    ${RESPOSTA_CONSULTA}    ${resposta_consulta.json()}
Conferir os dados retornados
    Log    ${RESPOSTA_CONSULTA}
    Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    nome             Fulano da Silva
    Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    email            ${EMAIL_TESTE}
    Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    password         1234
    Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    administrador    true
    Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    _id              ${ID_USUARIO}

Realizar Login com o usuário
    ${body}  Create Dictionary
    ...      email=${EMAIL_TESTE}
    ...      password=1234  
    
    Criar Sessao na ServerRest

    ${resposta}    POST On Session    
    ...            alias=ServerRest
    ...            url=/login
    ...            json=${body}
    ...            expected_status=200
    
    Set Test Variable    ${resposta}    ${resposta.json()}

Conferir se o Login ocorreu com sucesso
    Log    ${resposta}
    Dictionary Should Contain Item    ${resposta}    message    Login realizado com sucesso
    Dictionary Should Contain Key   ${resposta}  authorization