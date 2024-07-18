# EstaparHelpCenter

Teste de desenvolvimento construindo a Central de Ajuda da Estapar. Você pode encontrar a definição do desafio [aqui](desafio.pdf).

## Requisitos

- iOS 17.5 ou mais recente
- Xcode 15.4 ou mais recente
- CocoaPods

## Projeto

Para auxiliar na organização do desenvolvimento, foi criado um [board no Github](https://github.com/users/wnhirsch/projects/9) para definir tarefas a serem concluídas para concluir a aplicação, assim separando o projeto em diversos passos. São eles:

1. [Configuração do Ambiente](https://github.com/wnhirsch/EstaparHelpCenter/issues/1)
2. [Configuração de Frameworks](https://github.com/wnhirsch/EstaparHelpCenter/issues/2)
3. [Construção da tela Home](https://github.com/wnhirsch/EstaparHelpCenter/issues/5)

Mais informações sobre cada etapa você encontrará nos tópicos a seguir.

## Frameworks

Como pedido no desafio, a aplicação foi construída utilizando UIKit, porém foi utilizado o Gerenciador de Frameworks [CocoaPod](https://cocoapods.org/) para nos fornecer o acesso a 3 frameworks para auxiliar na construção da aplicação:

- [Alamofire](https://cocoapods.org/pods/Alamofire): Para facilitar as chamadas de API definindo uma interface mais amigável que a nativa do Swift.
- [Moya](https://cocoapods.org/pods/Moya): Para facilitar o próprio uso do Alamofire, servindo como um auxiliar da framework.
- [Kingfisher](https://cocoapods.org/pods/Kingfisher): Para facilitar a captura e cache de imagens.
- [SnapKit](https://cocoapods.org/pods/SnapKit): Para facilitar a definição de `constraints` com o UIKit.

Em resumo, todas as frameworks utilizadas são ferramentas que eliminam a complexidade do código pela definição de interfaces mais amigáveis para funcionalidades comuns em uma aplicação. Algumas dessas frameworks acabam sendo úteis apenas com UIKit, pois o SwiftUI acabou aderindo com algumas dessas facilitações. Seria possível não utilizar nenhuma delas, mas apenas deixaria o desafio mais complicado sem um retorno positivo, estaria reinventando a roda.

## Home do App

Ao visualizar o Figma da aplicação, percebemos que todo o fluxo da Central de Ajuda está dentro de uma modal que foi chamada de algum outro fluxo, provavelmente a Home do App. Sendo assim, além das 2 telas principais, foi criado uma tela extra apenas para criar o efeito do fluxo ser chamado por outro.

Essa tela possui um fundo branco e um botão para abrir a modal da Central de Ajuda, porém, por padrão, essa abertura acontece automaticamente na inicialização, fazendo o botão apenas servir como apoio caso a modal seja fechada.

