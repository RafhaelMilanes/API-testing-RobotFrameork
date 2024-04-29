# API TESTING ROBOT

## Visão Geral
Este projeto automatiza testes de API relacionados a usuários em um servidor utilizando o Robot Framework com as bibliotecas RequestsLibrary e SeleniumLibrary. Os casos de teste abrangem cenários como criar um novo usuário, verificar se o usuário foi registrado com sucesso, evitar o registro de usuários duplicados, recuperar dados do usuário e fazer login com um usuário criado.

## Pré-requisitos
- Robot Framework
- RequestsLibrary
- SeleniumLibrary

## Estrutura do Projeto
- **Settings:** Configurações de localização de recursos e bibliotecas utilizadas.
- **Test Cases:** Contém casos de teste detalhados cobrindo vários cenários.
- **Keywords:** Palavras-chave personalizadas definindo ações reutilizáveis.

## Execução dos Testes
1. Garanta que todos os pré-requisitos estejam instalados.
2. Navegue até o diretório do projeto.
3. Execute `robot api_testing_usuarios.robot` para executar os testes.

## Conhecimento Adquirido

Desenvolvendo este projeto, obtive uma compreensão mais profunda da automação de testes de API usando o Robot Framework. Aprendi a configurar e utilizar a biblioteca RequestsLibrary para realizar solicitações HTTP e a biblioteca SeleniumLibrary para interagir com elementos da web. Além disso, percebi a importância de organizar os casos de teste em cenários específicos para uma melhor compreensão e manutenção do código. Esta experiência ampliou minha habilidade em automatizar testes de software e fortaleceu meu entendimento sobre boas práticas de teste e desenvolvimento de software.
