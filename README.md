![StoneSDK](https://cloud.githubusercontent.com/assets/2567823/11539067/6300c838-990c-11e5-9831-4f8ce691859e.png)

![Objective-C](https://img.shields.io/badge/linguagem-Objective--C-green.svg?style=plastic) ![Swift](https://img.shields.io/badge/linguagem-Swift-blue.svg?style=plastic)

SDK de integração para iOS.

[This document in English 🇬🇧🇬🇧🇬🇧🇬🇧🇬🇧🇬🇧🇬🇧](https://github.com/stone-payments/sdk-ios-v2/blob/master/README_en.md)

> Download do último release pode ser feito em [releases](https://github.com/stone-pagamentos/sdk-ios-v2/releases).

## Funcionalidades

- Ativação do Stone Code
- Criação de sessão com o pinpad
- Download / carragamento das tabelas AID e CAPK
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

É necessário que a aplicação habilite TLS v1.2 para a comunicação com nossos servidores. Para isso adicione as linhas de código a seguir no `Info.plist` (clique no arquivo `Info.plist` com o botão direito do mouse e selecione `Open As` > `Source Code`):

```xml
<key>NSAppTransportSecurity</key>
	<dict>
		<key>NSExceptionDomains</key>
		<dict>
			<key>stone.com.br</key>
			<dict>
				<key>NSExceptionMinimumTLSVersion</key>
				<string>TLSV1.2</string>
				<key>NSExceptionRequiresForwardSecrecy</key>
				<false/>
				<key>NSIncludesSubdomains</key>
				<true/>
			</dict>
		</dict>
	</dict>
```

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

O mesmo deverá ficar como na imagem abaixo:

![info.plist](https://cloud.githubusercontent.com/assets/2567823/13082778/3ce6afbc-d4b9-11e5-9cdf-0764a8970f73.png)


## Exemplos de Código

- [Objective-C](https://github.com/stone-pagamentos/sdk-ios-v2/tree/master/objc)
- [Swift](https://github.com/stone-pagamentos/sdk-ios-v2/tree/master/swift)
