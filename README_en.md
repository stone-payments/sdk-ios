![StoneSDK](https://cloud.githubusercontent.com/assets/2567823/11539067/6300c838-990c-11e5-9831-4f8ce691859e.png)

![Objective-C](https://img.shields.io/badge/linguagem-Objective--C-green.svg?style=plastic) ![Swift](https://img.shields.io/badge/linguagem-Swift-blue.svg?style=plastic)

Integration SDK for iOS.

> The latest releases can be downloaded in [releases](https://github.com/stone-pagamentos/sdk-ios-v2/releases).

## Features

- Merchant activation
- Pinpad communication
- Load AID and CAPK tables
- Perform transaction
- Transaction cancellation
- Transaction list
- Transaction receipt via email

## Requirement

- iOS 8.0+
- Xcode 7.1+

## Contact

In case you have any problem open an [issue](https://github.com/stone-payments/sdk-ios-v2/issues).

## Installation

Add the `StoneSDK.framework` as embedded binaries.

In the `Info.plist` of the project add the property `Supported external accessory protocols` in the `Custom iOS Target Properties` containing the protocols for the pinpad that is going to be used in the app.

In the `Build Settings` select `No` for `Enable Bitcode`. You can find it in the section `Build Options`.

Add the script bellow in the `Build Phases` (Open `Build Phases`, click on the plus sign and select `New Run Script Phase`).

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

## Available providers

- [STNPinPadConnectionProvider](#connecting-to-pinpads) - Establish session between application and pinpad

- [STNStoneCodeActivationProvider](#stone-code-activation) - Activate merchant's Stone Code

- [STNTableLoaderProvider](#loading-aid-and-capk-tables-to-the-pinpad) - Load AID and CAPK tables to pinpad

- [STNTransactionProvider](#sending-transactions) - Read customer's card and send transaction

- [STNTransactionListProvider](#transaction-listing)  - List transaction history

- [STNCaptureTransactionProvider](#capture-transaction)  - Perform posterior transaction capture

- [STNMerchantListProvider](#merchant-listing)  - List activated merchants in the application

- [STNCancellationProvider](#cancelling-transactions) - Cancel transaction (refund)

- [STNMailProvider](#send-receipt-via-email) - Send receipt email for transaction and cancellation

- [STNValidationProvider](#validations) - Do some validations (as if the session with pinpad is closed, tables are downloaded)

- [STNCardProvider](#fetch-pan) - Get 4 last digits in the credit card

- [STNDisplayProvider](#display-message-on-pinpad) - Display mesage on pinpad's screen

- [STNLoggerProvider](#logger) - Get SDK console printed messages

## Available models

- [STNTransactionModel](#transaction) - Transaction properties

- [STNMerchantModel](#merchant) - Merchant properties

- [STNPinpadModel](#pinpad) - Pinpad properties

- [STNAddressModel](#address) - Merchant's address properties

- [STNReceiptModel](#receipt) - Transaction receipt properties

## Other available objects

- [STNConfig](#configurations) - General configurations

- [STNPinpad]() - Pinpad object representation

## Models

Some providers return object models that can be used by the SDK user.

### Transaction

The `STNTransactionModel` has all the informations about the transaction.

#### Properties list

- amount (**NSNumber**) - transaction value without decimal separators (eg.: for R$ 10.00 it will be 1000)
- instalmentAmount (**STNTransactionInstalmentAmount**) - the amount of instalments
- balance (**NSNumber**) - balance for vouchers (eg.: Ticket, Sodexo)
- instalmentType (**STNInstalmentType**) - type of instalment
- aid (**NSString**) - AID code
- arqc (**NSString**) - ARQC code
- type (**STNTransactionTypeSimplified**) - Debit or credit
- typeString (**NSString**) - transaction type as string
- status (**STNTransactionStatus**) - approved, cancelled, denied...
- statusString (**NSString**) - transaction status as string
- date (**NSDate**) - transaction date
- dateString (**NSString**) - transaction date as string
- receiptTransactionKey (**NSString**) - transaction ID
- reference (**NSString**) - transaction reference number
- pan (**NSString**) - 4 last digits of the card used in the transaction
- cardBrand (**NSString**) - card brand
- cardHolderName (**NSString**) - card holder name
- authorizationCode (**NSString**) - Stone ID
- initiatorTransactionKey (**NSString**) - ID that can be set by user
- shortName (**NSString**) - custom name for the customer's invoice
- merchant (**STNMerchantModel**) - merchant used in the transaction
- pinpad (**STNPinpadModel**) - pinpad used in the transaction
- entryMode (**STNTransactionEntryMode**): whether the transaction was made by magnetic stripe (`STNTransactionEntryModeMagneticStripe`) or chip and pin (`STNTransactionEntryModeChipNPin`)
- signature (**NSData**): allows to store a binary image of the cardholder signature
- cvm (**NSString**): the cardholder verification method, as a string representing the hex value sent by the pinpad (only for EMV chip transactions)
- serviceCode (**NSString**): indicates what types of charges can be accepted, saved as a string representing the hex value sent by the pinpad (gathered on both EMV and magnetic stripe transactions)
- actionCode (**NSString**): authorization response code
- subMerchantCategoryCode (**NSString**):  sub merchant category code
- subMerchantAddress (**NSString**): sub merchant address

### Merchant

Merchant's informations.

#### Properties list

- saleAffiliationKey (**NSString**) - Afiliation key
- documentNumber (**NSString**) - CPF/CNPJ
- merchantName (**NSString**) - Merchant name
- stonecode (**NSString**) - Stone Code
- address (**STNAddressModel**) - Address
- transactions (**NSOrderedSet<STNTransactionModel>**) - Transactions list

### Pinpad

Pinpad informations.

#### Properties list

- name (**NSString**) - name
- model (**NSString**) - model
- serialNumber (**NSString**) - serial number
- transaction (**STNTransactionModel**) - transaction sent by this pinpad

### Address

Address information.

#### Properties list

- city (**NSString**) - city
- district (**NSString**) - state
- neighborhood (**NSString**) - neighborhood
- street (**NSString**) - street
- doorNumber (**NSString**) - number
- complement (**NSString**) - complement
- zipCode (**NSString**) - zip code
- merchant (**STNMerchantModel**) - the merchant in which this address belongs to


## Others

### Pinpad

`STNPinpad`  is an object representing the pinpad.

#### Properties list

- name (**NSString**) - device name
- identifier (**NSString**) - the UUID of BLE devices, or the connection ID of Bluetooth devices
- alias (**NSString**): custom name
- device (**id**): it stores the CBPeripheral (BLE) or the EAAccessory (Bluetooth) object.


### Error code

You can check error code by value or by it's enumaration. Possible values:

- 101 - generic error (**STNErrorCodeGenericError**)
- 102 - missing parameter (**STNErrorCodeMissingParameter**)
- 103 - error sending email (**STNErrorCodeEmailMessageError**)
- 105 - exceeded the maximum number of characters (**STNErrorCodeNumberOfCharactersExceeded**)
- 106 - exceeded the maximum number of characters for the property `shortName` (**STNErrorCodeNumberOfCharactersExceededForShortName**)
- 110 - error on the command FNC (**STNErrorCodeMissingStonecodeActivation**)
- 201 - no merchant activated (**STNErrorCodeMissingStonecodeActivation**)
- 202 - merchant already activated (**STNErrorCodeStonecodeAlreadyActivated**)
- 202 - invalid parameter (**STNErrorCodeInvalidParameter**)
- 203 - invalid amount for transaction (**STNErrorCodeInvalidAmount**)
- 204 - transaction cancelled during transaction (**STNErrorCodeTransactionAutoCancel**)
- 205 - invalid transaction (**STNErrorCodeTransactionFailed**)
- 206 - transaction failed (**STNErrorCodeTransactionFailed**)
- 207 - transaction timeout (**STNErrorCodeTransactionTimeout**)
- 209 - Wrong Stone code (**STNErrorCodeTransactionAlreadyCancelled**)
- 210 - transaction already cancelled (**STNErrorCodeTransactionAlreadyCancelled**)
- 211 - transaction denied (**STNErrorCodeTransactionRejected**)
- 214 - operation cancelled by user (**STNErrorCodeOperationCancelledByUser**)
- 215 - card removed by user (**STNErrorCardRemovedByUser**)
- 220 - table content not found at device (**STNErrorCodeMissingTableContent**)
- 221 - invalid card application (**STNErrorCodeInvalidCardApplication**)
- 303 - no session with pinpad found (**STNErrorCodePinpadConnectionNotFound**)
- 304 - no AID and CAPK tables found (**STNErrorCodeTablesNotFound**)
- 305 - error loading tables to pinpad  (**STNErrorCodeNullResponse**)
- 306 - request error (**STNErrorCodeNullResponse**)
- 307 - table version not found (**STNErrorCodeTableVersionNotFound**)
- 308 - pinpad communication failed (**STNErrorCodePinpadCommunicationFailed**)
- 309 - unable to catch the response from device in the expected time (**STNErrorCodePinpadCommandTimeout**)
- 310 - invalid device (**STNErrorCodePinpadNotValid**)
- 311 - unable to connect to pinpad (**STNErrorCodePinpadUnableToConnect**)
- 401 - bluetooth not ready (**STNErrorBluetoothNotReady**)
- 601 - no internet connection (**STNErrorCodeNotConnectedToNetwork**)


> Contact integracoes@stone.com.br for more details.
