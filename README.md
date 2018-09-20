![StoneSDK](https://cloud.githubusercontent.com/assets/2567823/11539067/6300c838-990c-11e5-9831-4f8ce691859e.png)

![Objective-C](https://img.shields.io/badge/linguagem-Objective--C-green.svg?style=plastic) ![Swift](https://img.shields.io/badge/linguagem-Swift-blue.svg?style=plastic)

SDK de integração para iOS.

[This document in English](https://github.com/stone-payments/sdk-ios-v2/blob/master/README_en.md)

> Download do último release pode ser feito em [releases](https://github.com/stone-pagamentos/sdk-ios-v2/releases).

## Funcionalidades

- Ativação do Stone Code
- Criação de sessão com o pinpad
- Carregamento das tabelas AID e CAPK
- Envio transações
- Cancelamento de transações
- Listagem das transações
- Envio de recibo por email

## Requisitos

- iOS 8.0+
- Xcode 7.1+

## Contato

Em caso de problemas abra uma [issue](https://github.com/stone-payments/sdk-ios-v2/issues).

## Instalação

Antes de começar a usar o StoneSDK é necessario seguir alguns procedimentos.

No target do projeto acesse a guia `General` e em `Embedded Binaries` adicione o `StoneSDK.framework` (é necessario que o arquivo esteja no diretorio do projeto).

Ainda no target do projeto, na guia `Info` adicione a propriedade `Supported external accessory protocols` em `Custom iOS Target Properties` e adicione os protocolos dos dispositivos bluetooth que terão permissão de se comunicar com o aplicativo.

Na guia `Build Settings`, em `Build Options`, selecione `No` para a configuração `Enable Bitcode`.

Adicione o script abaixo em `Build Phases` (Em `Build Phases`, clique sinal de "mais" e selecione `New Run Script Phase`).

```bash
FRAMEWORK="StoneSDK"
FRAMEWORK_EXECUTABLE_PATH="${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/$FRAMEWORK.framework/$FRAMEWORK"
EXTRACTED_ARCHS=()
for ARCH in $ARCHS
do
lipo -extract "$ARCH" "$FRAMEWORK_EXECUTABLE_PATH" -o "$FRAMEWORK_EXECUTABLE_PATH-$ARCH"
EXTRACTED_ARCHS+=("$FRAMEWORK_EXECUTABLE_PATH-$ARCH")
done
lipo -o "$FRAMEWORK_EXECUTABLE_PATH-merged" -create "${EXTRACTED_ARCHS[@]}"
rm "${EXTRACTED_ARCHS[@]}"
rm "$FRAMEWORK_EXECUTABLE_PATH"
mv "$FRAMEWORK_EXECUTABLE_PATH-merged" "$FRAMEWORK_EXECUTABLE_PATH"
```

## Lista de providers disponíveis

- [STNPinPadConnectionProvider](#criação-de-sessão-com-o-pinpad) - Estabelece sessão entre o aplicativo e o pinpad

- [STNStoneCodeActivationProvider](#ativação-do-stone-code) - Ativa o Stone Code do lojista

- [STNTableLoaderProvider](#carregamento-das-tabelas-aid-e-capk-para-o-pinpad) - Carrega as tabelas AID e CAPK para o pinpad

- [STNTransactionProvider](#envio-de-transações) - Captura o cartão do comprador e envia a transação

- [STNTransactionListProvider](#listagem-de-transações)  - Lista transações com opção de listar pelo cartão do comprador

- [STNCaptureTransactionProvider](#capture-transaction)  - Envio de captura de transação posterior

- [STNMerchantListProvider](#listagem-de-lojistas)  - Lista lojistas ativados no aplicativo

- [STNCancellationProvider](#cancelamento-de-transações) - Cancelamento de transações

- [STNMailProvider](#envio-de-comprovante-por-email) - Envia email com comprovante da transação ou cancelamento

- [STNValidationProvider](#validações) - Responsavel pelas seguintes validações: se há conexão com a internet, se o Stone Code está ativado, se há conexão com o pinpad e se as tabelas já foram baixadas

- [STNCardProvider](#captura-de-pan) - Captura os 4 últimos números do cartão

- [STNDisplayProvider](#exibição-no-display-do-pinpad) - Exibe mensagem de até 32 caracteres no visor do pinpad

- [STNLoggerProvider](#logger) - Exibe mensagens do log de eventos da SDK

## Lista de models disponíveis

- [STNTransactionModel](#transação) - Model com propriedades da transação

- [STNMerchantModel](#lojista) - Model com propriedades do lojista

- [STNPinpadModel](#pinpad) - Model com propriedades do pinpad

- [STNAddressModel](#endereço) - Model com propriedades de endereço do lojista

- [STNReceiptModel](#receipt) - Model com propriedades do recibo de transação


## Outros objetos disponíveis

- [STNConfig](#configurations) - Configurações gerais

- [STNPinpad]() - Objeto de representação de Pinpad

## Models

Alguns providers retornam models que podem ser usados pelo usuário do SDK.

### Transação

O model `STNTransactionModel` disponibiliza, em suas propriedades, informações de uma transação.

#### Lista de propriedades

- amount (**NSNumber**) - valor da transação no formato de centavos (ex: 10,00 vai ser 1000. Basta multiplicar por 0.01 para obter o valor real.)
- instalmentAmount (**STNTransactionInstalmentAmount**) - número de parcelas da transação
- balance (**NSNumber**) - saldo de vouchers (ex.: Ticket, Sodexo)
- instalmentType (**STNInstalmentType**) - tipo de parcelamento da transação
- aid (**String**) - Código AID da transação
- arqc (**String**) - código ARQC da transação
- type (**STNTransactionTypeSimplified**) - Débito ou crédito
- typeString (**String**) - string que representa a propriedade `type`
- status (**STNTransactionStatus**) - aprovada, cancelada, negada...
- statusString (**String**) - string que representa a propriedade `status`
- date (**Date**) - Data da transação
- dateString (**String**) - string que representa a propriedade `date`
- receiptTransactionKey (**String**) - ID da transação
- reference (**String**) - referencia da transação
- pan (**String**) - 4 últimos números do cartão
- cardBrand (**String**) - bandeira do cartão
- cardHolderName (**String**) - nome do portador do cartão
- authorizationCode (**String**) - Stone ID
- initiatorTransactionKey (**String**) - identificação da transação
- shortName (**String**) - nome customizado exibido na fatura (se não for definido será `nil`)
- merchant (**STNMerchantModel**) - lojista que passou a transação
- pinpad (**STNPinpadModel**) - pinpad que passou a transação
- entryMode (**STNTransactionEntryMode**): determina o tipo de cartão aplicado, Ex. `STNTransactionEntryModeMagneticStripe` para cartões de tarja magnética ou com chip e senha: `STNTransactionEntryModeChipNPin`
- signature (**NSData**): arquivo binário com imagem para assinatura do titular do cartão
- cvm (**NSString**): string enviada pelo pinpad em hexadecimal para método de verificação deo titular do cartão (apenas cartões com chip EMV)
- serviceCode (**NSString**): string enviada pelo pinpad em hexadecimal que indica os tipos de cobranças aceitos (coletado tanto em versões magnéticas quanto com chip EMV)
- actionCode (**NSString**): código de resposta da autorização
- subMerchantCategoryCode (**NSString**):  código da categoria do sub comerciante/lojista
- subMerchantAddress (**NSString**): endereço do sub comerciante/lojista

### Lojista

O model `STNMerchantModel` disponibiliza, em suas propriedades, informações do lojista/usuário do aplicativo.

#### Lista de propriedades

- saleAffiliationKey (**String**) - Afiliation key
- documentNumber (**String**) - CPF/CNPJ
- merchantName (**String**) - Nome do lojista
- stonecode (**String**) - Stone Code
- address (**STNAddressModel**) - Endereço do lojista
- transactions (**NSOrderedSet<STNTransactionModel>**) - transações do lojista

### Pinpad

O model `STNPinpadModel` disponibiliza, em suas propriedades, informações do pinpad.

#### Lista de propriedades

- name (**String**) - nome
- model (**String**) - modelo
- serialNumber (**String**) - número de serie
- transaction (**STNTransactionModel**) - transação passada com o pinpad

### Endereço

O model `STNAddressModel` disponibiliza, em suas propriedades, informações de endereço.

#### Lista de propriedades

- city (**String**) - cidade
- district (**String**) - estado
- neighborhood (**String**) - bairro
- street (**String**) - rua
- doorNumber (**String**) - número
- complement (**String**) - complemento
- zipCode (**String**) - CEP
- merchant (**STNMerchantModel**) - lojista que possui esse endereço

## Outros

### Pinpad

`STNPinpad` objeto representando o pinpad.

#### Lista de propriedades

- name (**NSString**) - nome do dispositivo
- identifier (**NSString**) - UUID nos casos de dispotivisos BLE, ou o serial number no caso dos dispositivos Bluetooth convencionais, ou a descrição do modelo no caso do PAX - D200.
- alias (**NSString**): nome personalizado
- device (**id**): referência ao objeto do dispositivo:  CBPeripheral para dispositivos low energy (BLE) ou EAAccessory para os demais.

### Códigos de erro

Você pode verificar o erro pelo valor ou pelo cógido. Possíveis valores:

- 101 - erro genérico (**STNErrorCodeGenericError**)
- 102 - ausência de parâmetro (**STNErrorCodeMissingParameter**)
- 103 - falha no envio de email (**STNErrorCodeEmailMessageError**)
- 105 - número de caracteres acima do permitido (**STNErrorCodeNumberOfCharactersExceeded**)
- 106 - número de caracteres acima do permitido para a propriedade `shortName` (**STNErrorCodeNumberOfCharactersExceededForShortName**)
- 110 - erro no comando FNC (**STNErrorCodeMissingStonecodeActivation**)
- 201 - falta ativar o Stone Code (**STNErrorCodeMissingStonecodeActivation**)
- 202 - Stone Code informado já foi ativado (**STNErrorCodeStonecodeAlreadyActivated**)
- 202 - parâmetro inválido (**STNErrorCodeInvalidParameter**)
- 203 - valor informado para transação é inválido (**STNErrorCodeInvalidAmount**)
- 204 - transação cancelada durante operação (**STNErrorCodeTransactionAutoCancel**)
- 205 - transação inválida (**STNErrorCodeTransactionFailed**)
- 206 - falha na transação (**STNErrorCodeTransactionFailed**)
- 207 - tempo da transação expirado (**STNErrorCodeTransactionTimeout**)
- 209 - Stone Code desconhecido (**STNErrorCodeTransactionAlreadyCancelled**)
- 210 - transação já foi cancelada (**STNErrorCodeTransactionAlreadyCancelled**)
- 211 - transação negada (**STNErrorCodeTransactionRejected**)
- 214 - operação cancelada pelo usuário (**STNErrorCodeOperationCancelledByUser**)
- 215 - cartão removido pelo usuário (**STNErrorCardRemovedByUser**)
- 220 - conteúdo de carga de tabelas não encontrado no dispositivo (**STNErrorCodeMissingTableContent**)
- 221 - aplicação de cartão invalida (**STNErrorCodeInvalidCardApplication**)
- 303 - conexão com o pinpad não encontrada (**STNErrorCodePinpadConnectionNotFound**)
- 304 - tabelas AID e CAPK não encontradas (**STNErrorCodeTablesNotFound**)
- 305 - erro ao carregar tabelas para o pinpad  (**STNErrorCodeNullResponse**)
- 306 - erro no request (**STNErrorCodeNullResponse**)
- 307 - versão de conteúdo de tabela não encontrada (**STNErrorCodeTableVersionNotFound**)
- 308 - falha de comunicação com pinpad (**STNErrorCodePinpadCommunicationFailed**)
- 309 - não foi possível obter uma resposta do dispositivo dentro do limite de tempo esperado (**STNErrorCodePinpadCommandTimeout**)
- 310 - dispositivo inválido (**STNErrorCodePinpadNotValid**)
- 311 - não foi possível conectar com o pinpad (**STNErrorCodePinpadUnableToConnect**)
- 401 - dispositivo bluetooth não está preparado (**STNErrorBluetoothNotReady**)
- 601 - erro na conexão com a internet (**STNErrorCodeNotConnectedToNetwork**)

> Para mais detalhes entre em contatoa través do e-mail: integracoes@stone.com.br.
