![StoneSDK](https://cloud.githubusercontent.com/assets/2567823/11539067/6300c838-990c-11e5-9831-4f8ce691859e.png)

![Objective-C](https://img.shields.io/badge/linguagem-Objective--C-green.svg)

SDK de integração para iOS.

> Download do último release pode ser feito em [releases](https://github.com/stone-pagamentos/sdk-ios-v2/releases).

## Features

- Ativação do Stone Code
- Criação de sessão com o pinpad
- Download / carragamento das tabelas AID e CAPK
- Listagem das transações
- Envio de recibo por email

## Requisitos

- iOS 7.1+
- Xcode 7.1+

## Contato

Em caso de problemas entrar em contato pelo email suporteios@stone.com.br.

## Instalação

Antes de começar a usar o StoneSDK é necessario seguir alguns procedimentos.

No target do projeto acesse a guia `Build Phases` e em `Link binary With Libraries` adicione os seguintes itens:

- libsqlite3.dylib (no caminho `Add Other > /usr/lib/libsqlite3.dylib`)
- SystemConfiguration.framework
- ExternalAccessory.framework
- StoneSDK.framework (é necessario que o arquivo esteja no diretorio do projeto)

Ainda no target do projeto, na guia `Info` adicione a propriedade `Supported external accessory protocols` em `Custom iOS Target Properties` e adicione os protocolos dos dispositivos bluetooth que terão permissão de se comunicar com o aplicativo.

## Lista de providers disponiveis

- STNCancellationProvider - Cancelamento de transações

- STNDisplayProvider - Exibe mensagem de até 32 caracteres no vizor do pinpad

- STNMailProvider - Envia email com comprovante da transação ou cancelamento

- STNPinPadConnectionProvider - Estabelece sessão entre o aplicativo e o pinpad

- STNStoneCodeActivationProvider - Ativa o Stone Code do lojista

- STNTableDownloaderProvider - Baixa tabelas AID e CAPK do servidor para o celular

- STNTableLoaderProvider - Carrega as tabelas AID e CAPK para o pinpad

- STNTransactionListProvider  - Lista transações com opção de listar pelo cartão do comprador

- STNTransactionProvider - Captura o cartão do comprador e envia a transação

- STNCardProvider - Captura os 4 últimos números do cartão

- STNTransactionInfoProvider - Provê o informações das transação

- STNUserInfoProvider - Contém informações do lojista/usuario do app

- STNValidationProvider - Responsavel pelas seguintes validações: se há conexão com a internet, se o Stone Code está ativado, se há conexão com o pinpad e se as tabelas já foram baixadas

## Utilização

### Importação das classes do SDK

Para acessar todas as classes do SDK basta importar o StoneSDK.

```objective-c
#import <StoneSDK/StoneSDK.h>
```

### Criação de sessão com o pinpad

Para realizar qualquer comunicação com o pinpad é necessario que se crie uma sessão. Lembrando que a conexão com o dispositivo bluetooth deve ser feita no menu de *Ajustes* do *iOS*.

> Antes de qualquer comunicação entre o aplicativo e o pinpad, uma sessão deve ser estabelecida.

```objective-c
STNPinPadConnectionProvider *pinPadConnectionProvider = [[STNPinPadConnectionProvider alloc] init];

    [pinPadConnectionProvider connectToPinpad:^(BOOL succeeded, NSError *error) {
        if (succeeded) // verifica se a requisição ocorreu com sucesso
        {
            // executa alguma coisa
        } else
        {
            // trata o erro
            NSLog(@"%@", error.description);
        }
    }];
```

> Recomendamos que esse método seja executado a cada **3 minutos** quando o aplicativo estiver em background caso usem o pinpad `Gertec MOBI PIN 10`. O dispositivo em questão apresentou problemas ao ficar muito tempo sem comunicação.

#### Possivel código de erro

303

### Ativação do Stone Code

O provider `STNStoneCodeActivationProvider` possui o método `activateStoneCode`, que recebe uma string com o Stone Code do lojista como parâmetro.

> O Stone Code deve ser ativado antes de realizar qualquer operação na Stone.

```objective-c
NSString *stoneCode = @"999999999"; // Stone Code do lojista

STNStoneCodeActivationProvider *activationProvider = [[STNStoneCodeActivationProvider alloc] init];

[activationProvider activateStoneCode:stoneCode withBlock:^(BOOL succeeded, NSError *error)
{
    if (succeeded) // verifica se a requisição ocorreu com sucesso
    {
        // em caso de sucesso,
        // executa alguma coisa
    } else
    {
        // em caso de erro,
        // faz alguma tratativa
        NSLog(@"%@", error.description);
    }
}];
```

#### Possíveis códigos de erro

101, 209

### Download das tabelas AID e CAPK

O provider `STNTableDownloaderProvider` possui o método `downloadTables` que faz o download das tabelas AID e CAPK para o dispositivo iOS.

> As tabelas AID e CAPK são necessarias para fazer transações EMV.

```objective-c
STNTableDownloaderProvider *tableDownloaderProvider = [[STNTableDownloaderProvider alloc] init];

[tableDownloaderProvider downLoadTables:^(BOOL succeeded, NSError *error)
{
    if (succeeded) // verifica se a requisição ocorreu com sucesso
    {
        // executa alguma coisa
    } else
    {
        // trata o erro
        NSLog(@"%@", error.description);
    }
}];
```

#### Possíveis códigos de erro

101, 601

### Carregamento das tabelas AID e CAPK para o pinpad

O provider `STNTableLoaderProvider` possui o método `loadTables` que faz o update das tabelas baixadas no dispositivo iOS para o pinpad.

```objective-c
STNTableLoaderProvider *tableLoaderProvider = [[STNTableLoaderProvider alloc] init];

[tableLoaderProvider loadTables:^(BOOL succeeded, NSError *error)
{
    if (succeeded) // verifica se a requisição ocorreu com sucesso
    {
        // executa alguma coisa
    } else
    {
        // trata o erro
        NSLog(@"%@", error.description);
    }
}];
```

#### Possivel código de erro

305

### Envio de transações

As transações são enviadas usando o método `sendTransactionWithValue` do provider `STNTransactionProvider`.

O método `sendTransactionWithValue` possui os parâmetros:

#### value

O primeiro parâmetro é o valor da transação e deve ser um `NSInteger` passado no formato de centavos. Por exemplo: caso queira enviar uma transação no valor de `R$ 56,45`, deve ser passado um `NSInteger` com o valor de `5645`. Uma transação no valor de R$ 0,05 deve ser passada como `5`.

#### transactionTypeSimplified

Nesse parâmetro deve ser informado se a transação é débito ou crédito. Para isso Podem ser usados os enums `TransactionCredit` para crédito ou `TransactionDebit` para débito.

#### instalmentTransaction

Parâmetro que informa o número de parcelas da transação. Um dos seguintes enums devem ser usados:

- `OneInstalment` - para 1x (à vista)
- `TwoInstalmetsNoInterest` - para 2x sem juros
- `ThreeInstalmetsNoInterest` - para 3x sem juros
- `FourInstalmetsNoInterest` - para 4x sem juros
- `FiveInstalmetsNoInterest` - para 5x sem juros
- `SixInstalmetsNoInterest` - para 6x sem juros
- `SevenInstalmetsNoInterest` - para 7x sem juros
- `EightInstalmetsNoInterest` - para 8x sem juros
- `NineInstalmetsNoInterest` - para 9x sem juros
- `TenInstalmetsNoInterest` - para 10x sem juros
- `ElevenInstalmetsNoInterest` - para 11x sem juros
- `TwelveInstalmetsNoInterest` - para 12x sem juros
- `TwoInstalmetsWithInterest` - para 2x com juros
- `ThreeInstalmetsWithInterest` - para 3x com juros
- `FourInstalmetsWithInterest` - para 4x com juros
- `FiveInstalmetsWithInterest` - para 5x com juros
- `SixInstalmetsWithInterest` - para 6x com juros
- `SevenInstalmetsWithInterest` - para 7x com juros
- `EightInstalmetsWithInterest` - para 8x com juros
- `NineInstalmetsWithInterest` - para 9x com juros
- `TenInstalmetsWithInterest` - para 10x com juros
- `ElevenInstalmetsWithInterest` - para 11x com juros
- `TwelveInstalmetsWithInterest` - para 12x com juros

#### transactionId

Deve receber uma string com a descrição da transação. Esse valor é **opcional** e pode ser recuperado no provider `STNTransactionInfoProvider`.

```objective-c
NSString *value = @"1000"; // valor correspondente a R$ 10,00
NSString *transactionId = @"Identificação da transação";

STNTransactionProvider *transactionProvider = [[STNTransactionProvider alloc] init];

[transactionProvider sendTransactionWithValue:(int *)[value integerValue] transactionTypeSimplified:TransactionCredit instalmentTransaction:OneInstalment transactionId:transactionId withBlock:^(BOOL succeeded, NSError *error)
{
    if (succeeded) // verifica se a requisição ocorreu com sucesso
    {
        // executa alguma coisa
    } else
    {
        // trata o erro
        NSLog(@"%@", error.description);
    }
}];
```

#### Possíveis códigos de erro

204, 205, 206, 207, 214, 601

### Listagem de transações

O provider `STNTransactionListProvider` possui os métodos, `listTransactions` e `listTransactionsByPan` que retornam um `NSArray` com as transações (`STNTransactionInfoProvider`) passadas no aplicativo. A ultima transação passada será sempre a primeira no array.

O método `listTransactions` retorna todas as transações realizadas.

```objective-c
STNTransactionListProvider *transactionListProvider = [[STNTransactionListProvider alloc] init];

// Array de transações
NSArray *transactions = [transactionListProvider listTransactions:^(BOOL succeeded, NSError *error)
{
    if (succeeded) // verifica se a requisição ocorreu com sucesso
    {
        // executa alguma coisa
    } else
    {
        // trata o erro
        NSLog(@"%@", error.description);
    }
}];

for (STNTransactionInfoProvider *transaction in transactions)
{
    NSLog(@"Valor da transação em centavos: %@", transaction.amount);
    NSLog(@"Status da transação: %@", transaction.status);
    NSLog(@"Data da transação: %@", transaction.date);
    NSLog(@"Descrição da transação: %@", transaction.transactionId);
}
```

Para obter as transações filtrando por um cartão especifico, o método `listTransactionsByPan` deve ser usado. Esse método solicitará a inserção de um cartão com chip. O resto é bem parecido com o método anterior.

```objective-c
STNTransactionListProvider *transactionListProvider = [[STNTransactionListProvider alloc] init];

// Array de transações
NSArray *transactions = [transactionListProvider listTransactionsByPan:^(BOOL succeeded, NSError *error)
{
    if (succeeded) // verifica se a requisição ocorreu com sucesso
    {
        // executa alguma coisa
    } else
    {
        // trata o erro
        NSLog(@"%@", error.description);
    }
}];

for (STNTransactionInfoProvider *transaction in transactions)
{
    NSLog(@"Valor da transação em centavos: %@", transaction.amount);
    NSLog(@"Status da transação: %@", transaction.status);
    NSLog(@"Data da transação: %@", transaction.date);
    NSLog(@"Descrição da transação: %@", transaction.transactionId);
}
```

#### Possíveis códigos de erro

101, 304

### Cancelamento de transações

O responsavel pelo cancelamento das transações é método `cancelTransaction` do provider `STNCancellationProvider`, que recebe, como parâmetro, o objeto de transação `STNTransactionInfoProvider`.

```objective-c
STNTransactionListProvider *transactionListProvider = [[STNTransactionListProvider alloc] init];

// preenche array com lista de transações
NSArray *transactions = [transactionListProvider listTransactions:^(BOOL succeeded, NSError *error){}];

// instacia o objeto de transação com a última transação realizada
STNTransactionInfoProvider *transactionInfo = transactions[0];

// instancia provider de cancelamento e executa
STNCancellationProvider *cancelation = [[STNCancellationProvider alloc] init];

[cancelation cancelTransaction:transactionInfo withBlock:^(BOOL succeeded, NSError *error)
{
    if (succeeded) // verifica se a requisição ocorreu com sucesso
    {
        // executa alguma coisa
    } else
    {
        // trata o erro
        NSLog(@"%@", error.description);
    }
}];
```

#### Possíveis códigos de erro

101, 210, 601

### Envio de comprovante por email

Para enviar comprovantes de transações por email basta usar o método `sendReceiptViaEmail` do provider `STNMailProvider`.

O método `sendReceiptViaEmail` possui os parâmetros:

#### mailTemplate

O primeiro parâmetro que deve ser informado é um enum que representa o template de email, podendo ser `TRANSACTION` para comprovantes de transação, ou `VOID_TRANSACTION` para comprovantes de cancelamento.

#### transactionInfo

O parâmetro transactionInfo deve receber um objeto do provider `STNTransactionInfoProvider` que terá as informações da transação.

#### destination

Destination deve conter uma string com o email do destinatario.

#### displayCompanyInformation

Esse parâmetro recebe um booleano que dirá se os dados do lojista (como endereço e CPF/CNPJ) serão exibidos no comprovante ou não.

> Alguns lojistas são pessoas físicas e querem que suas informações não sejam exibidas.

```objective-c
STNTransactionListProvider *transactionListProvider = [[STNTransactionListProvider alloc] init];

NSArray *transactions = [transactionListProvider listTransactions:^(BOOL succeeded, NSError *error) {}];

// destinatario
NSString *destination = @"fulano@destino.com.br";

STNMailProvider *mailProvider = [[STNMailProvider alloc] init];

// envia email com comprovante da última transação realizada
[mailProvider sendReceiptViaEmail:TRANSACTION transactionInfo:transactions[0] toDestination:destination displayCompanyInformation:YES withBlock:^(BOOL succeeded, NSError *error)
{
    if (succeeded) // verifica se a requisição ocorreu com sucesso
    {
        // executa alguma coisa
    } else
    {
        // trata o erro
        NSLog(@"%@", error.description);
    }
}];
```

#### Possíveis códigos de erro

103, 601

### Validações

O provider `STNValidationProvider` possui 3 métodos de validação:

#### validateActivation

Verifica se o Stone Code já foi ativado e retorna `YES` caso positivo.

#### validatePinpadConnection

Valida se o pinpad está pareado com o dispositivo **iOS** e retorna `YES` caso positivo.

> Lembrando que para a comunicação ocorrer ainda é necessario estabelecer uma sessão.

#### validateTablesDownloaded

Checa se as tabelas AID e CAPK já foram baixadas para o dispositivo **iOS** e retorna `YES` caso positivo.


```objective-c
if ([STNValidationProvider validateActivation] == YES)
{
    NSLog(@"Stone Code está ativado!");
}

if ([STNValidationProvider validatePinpadConnection] == YES)
{
    NSLog(@"O pinpad está pareado com o dispositivo iOS!");
}

if ([STNValidationProvider validateTablesDownloaded] == YES)
{
    NSLog(@"As tabelas já foram baixadas para o dispositivo iOS!");
}
```

> É importante que essas validações sejam executadas e tratadas antes de realizar as operações.

### Captura de PAN

Para capturar o PAN (4 últimos dígitos do cartão) deve ser usado o método `getCardPan` do provider `SNTCardProvider`.

```objective-c
NSString *pan = [cardProvider getCardPan:^(BOOL succeeded, NSError *error)
    {
        if (succeeded) // verifica se a requisição ocorreu com sucesso
        {
            // executa alguma coisa
        } else
        {
            // trata o erro
            NSLog(@"%@", error.description);
        }
    }];

NSLog(@"**** **** **** %@", pan);
```

#### Possíveis códigos de erro

101, 304

### Informações sobre a transação

O provider `STNTransactionInfoProvider` disponibiliza, em suas propriedades, informações de uma transação.

#### Lista de propriedades

- amount - Valor da transação no formato de centavos (ex: 10,00 vai ser 1000. Basta multiplicar por 0.01 para obter o valor real.)
- instalments - Número de parcelas da transação
- aid - Código AID da transação
- arqc - código ARQC da transação
- type - Débito ou crédito
- status - Aprovada ou cancelada
- date - Data da transação
- receiptTransactionKey - ID da transação
- reference - Referencia da transação
- pan - 4 últimos número do cartão
- flag - Bandeira do cartão
- cardHolderName - Nome do portador do cartão
- authorizationCode - Stone ID
- transactionId - String contendo identificação da transação (valor opcional, pode ser usado pelo integrador para armazenar alguma informação)

### Informações sobre o lojista

O provider `STNUserInfoProvider` disponibiliza, em suas propriedades, informações do lojista/usuario do aplicativo.

#### Lista de propriedades

- afKey - Afiliation key
- documentNumber - CPF/CNPJ
- store - Nome do lojista
- address - Endereço do lojista
- stonecode - Stone Code


### Códigos de erro

- 101 - erro genérico
- 103 - falha no envio de email
- 105 - número de caracteres acima do permitido
- 204 - transação cancelada durante operação
- 205 - transação inválida
- 206 - falha na transação
- 207 - tempo da transação expirado
- 209 - Stone Code desconhecido
- 210 - Transação já foi cancelada
- 214 - operação cancelada pelo usuario
- 303 - conexão com o pinpad não encontrada
- 304 - tabelas AID e CAPK não encontradas
- 305 - erro ao carregar tabelas para o pinpad
- 601 - erro na conexão com a internet
