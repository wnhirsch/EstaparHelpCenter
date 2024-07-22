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
4. [Construção da Home da Central de Ajuda](https://github.com/wnhirsch/EstaparHelpCenter/issues/7)
5. [Construção da Tela de Detalhes de Categoria](https://github.com/wnhirsch/EstaparHelpCenter/issues/9)

Mais informações sobre cada etapa você encontrará nos tópicos a seguir.

## Frameworks

Como pedido no desafio, a aplicação foi construída utilizando UIKit, porém foi utilizado o Gerenciador de Frameworks [CocoaPod](https://cocoapods.org/) para nos fornecer o acesso a 3 frameworks para auxiliar na construção da aplicação:

- [Alamofire](https://cocoapods.org/pods/Alamofire): Para facilitar as chamadas de API definindo uma interface mais amigável que a nativa do Swift.
- [Moya](https://cocoapods.org/pods/Moya): Para facilitar o próprio uso do Alamofire, servindo como um auxiliar da framework.
- [Kingfisher](https://cocoapods.org/pods/Kingfisher): Para facilitar a captura e cache de imagens.
- [SnapKit](https://cocoapods.org/pods/SnapKit): Para facilitar a definição de `constraints` com o UIKit.

Em resumo, todas as frameworks utilizadas são ferramentas que eliminam a complexidade do código pela definição de interfaces mais amigáveis para funcionalidades comuns em uma aplicação. Algumas dessas frameworks acabam sendo úteis apenas com UIKit, pois o SwiftUI acabou aderindo com algumas dessas facilitações. Seria possível não utilizar nenhuma delas, mas apenas deixaria o desafio mais complicado sem um retorno positivo, estaria reinventando a roda.

## Arquitetura

Foi utilizado a arquitetura **MVVM-C** (Model, View, ViewModel e Coordinator) para a construção do projeto. Os `Coordinators` foram extremamente úteis para remover da `ViewController` as operações de transição, ainda mais com o uso de Modal. Com essa arquitetura, a hierarquia de arquivos do projeto ficou da seguinte forma:

- **Core**: Diretório contendo todos os principais arquivos base do projeto.
	- **API**: Diretório contendo configurações de Rede.
	- **Strings**: Diretório contendo o dicionário de textos do App.
	- **Extensions**: Diretório contendo extensão de tipos já existentes para facilitar o nosso contexto.
	- **UI**: Diretório contendo componentes genéricos do projeto, não pertencentes a nenhum fluxo fixo.
- **Scenes**: Diretório com todos os fluxos do App.
	- **"Fluxo"**: Diretório com todas as telas e classes gerais de um fluxo.
		- **Models**: Diretório contendo todos os modelos/estruturas de dados usadas nesse fluxo.
		- **"Tela"**: Diretório que representa uma tela de um fluxo.
			- **"TelaView"**: A classe que constroi uma tela programaticamente com *ViewCode*.
			- **"TelaViewModel"**: A classe que gerencia os dados a serem injetados e usados nessa tela.
			- **"TelaViewController"**: A classe de controle que gerencia a comunicação entre o construtor da tela e o gerenciador de dados (View e ViewModel).
			- **"Components"**: Diretório opicional que aparece contendo outros construtores por *ViewCode* de itens que aparecem somente na **"TelaView"**, facilitando a abstração e manutenção por quebrar a **"TelaView"** em porções menores.
		- **"FluxoCoordinator"**: `Coordinator` do fluxo que gerencia todo redirecionamento desse fluxo intera e externamente.
		- **"FluxoWorker"**: Classe com a definição de todas as requisições de API desse fluxo.
- **Support Files**: Diretório com arquivos extras como repositório de Assets e Fontes.

## Home do App

Ao visualizar o Figma da aplicação, percebemos que todo o fluxo da Central de Ajuda está dentro de uma modal que foi chamada de algum outro fluxo, provavelmente a Home do App. Sendo assim, além das 2 telas principais, foi criado uma tela extra apenas para criar o efeito do fluxo ser chamado por outro.

Essa tela possui um fundo branco e um botão para abrir a modal da Central de Ajuda, porém, por padrão, essa abertura acontece automaticamente na inicialização, fazendo o botão apenas servir como apoio caso a modal seja fechada.

## Home da Central de Ajuda

A Tela Inicial do Centro de Ajuda foi construida conforme a descrição do Figma, seguindo os mesmos padrões de fonte, cores, espaçamento, tamanhos e lógica de funcionamento. Passei por algumas decisões na hora do desenvolvimento e gostaria de pontuá-las aqui:

- Adicionei um `loading` na tela para, em caso de atrasos no carregamento da API, o usuário tenha um feedback visual sobre isso.
- Adicionei também um handler de erro para a chamada de API que exibe uma mensagem informando o problema e oferecendo tentar novamente ou cancelar a operação, fechando a modal.
- Adicionei uma mensagem de lista vazia para quando a chamada de API for bem sucedidada, porém a lista de categorias estiver vazia.
- Optei por apenas substituir o valor `%firstname%` contido na string enviada pela API por um valor hardcoded.
- Optei por usar matemática e alguns truques de linguagem para fazer o efeito da imagem do Header encolher com a `UICollectionView`. Se eu fizesse definindo o header dentro da `UICollectionView`, a organização dos elementos não ficaria tão do meu aguardo, já com essa solução consigo deixar ambos separadas, porém alcançando o efeito almejado. Minha estratégia foi capturar o `contentOffset.y` da `UIScrollView` contida dentro da `UICollectionView`, imaginar todos os estados possíveis da do Scroll e para onde eu devo chegar dada cada diferente alteração. Após isso atualizo o tamanho do header, o alpha da imagem e o próprio `contentOffset.y`. Deixei comentários descritívos no código.

## Tela de Detalhes de Categoria

A Tela de Detalhes de uma Categoria do Centro de Ajuda também foi construida conforme a descrição do Figma e também tiveram decisões a serem tomadas durante o desenvolvimento

- As adições extras relacionadas ao `loading`, mensagem de lista vazia e handler de erro mencionadas anteriormente foram propagadas para essa tela.
- O algoritmo de pesquisa que eu escolhi para encontrar os artigos começa limpando a sentença do campo de pesquisa, removendo espaços extras, acentos e minimiza todas as letras, e, em seguida, separa em palavras. Cada palavra será comparada com cada palavra de cada um dos títulos dos artigos. Optei por buscar pelo prefixo, em outras palavras, o título do artigo deve ter alguma palavra que comece com as palavras filtradas. Eu pensei em buscar pela substring, mas não achei intuitivo para palavras pequenas, de qualquer forma é uma decisão fácil de ajustar, apenas alterar um comando. Se o título do artigo tiver pelo menos 1 palavra que tenha cada um dos prefixos buscados, ele é válido de aparecer, se não é cortado, ou seja, pode dar match com todas as palavras, se falhar 1 não irá aparecer.
- A construção dos cards expansivos foi feita utilizando uma `UITableView`, separando 1 `section` para cada card com o título da categória ficando no `headerView` da tabela. O maior desafio foi desenhar a borda do card expansivo porque uma `section` não é uma entidade que agrupa o cabeçalho e as células, então minha estratégia foi desenhar a borda manualmente no cabeçalho, em cada célula e em um `footer`, cada item preenchendo um pedaço da borda total.
