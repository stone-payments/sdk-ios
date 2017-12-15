![StoneSDK](https://cloud.githubusercontent.com/assets/2567823/11539067/6300c838-990c-11e5-9831-4f8ce691859e.png)

![Objective-C](https://img.shields.io/badge/linguagem-Objective--C-green.svg?style=plastic) ![Swift](https://img.shields.io/badge/linguagem-Swift-blue.svg?style=plastic)

Integration SDK for iOS.

> The latest releases can be downloaded in [releases](https://github.com/stone-pagamentos/sdk-ios-v2/releases).

## Features

- Merchant activation
- Pinpad communication
- Download/load AID and CAPK tables
- Perform transaction
- Transaction cancellation
- Transaction list
- Transaction receipt via email

## Requirement

- iOS 8.0+

## Contact

In case you have any problem open an [issue](https://github.com/stone-payments/sdk-ios-v2/issues).

## Installation

Add the `StoneSDK.framework` as embedded binaries.

In the `Info.plist` of the project add the property `Supported external accessory protocols` in the `Custom iOS Target Properties` containing the protocols for the pinpad that is going to be used in the app.

Still in the `Info.plist` it is necessary to add support for TLS v1.2 to be able to connect to our servers. Simply add the following code to your `Info.plist` file.

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

<!-- ## Homologation environment

If you want to use the homologation environment add the key `Stone Homologation` type `Boolean` on project's `Info.plist`. Use `YES` or `NO` to turn it on or off. -->

## Available providers

- [STNPinPadConnectionProvider](#connecting-to-pinpads) - Establish session between application and pinpad

- [STNStoneCodeActivationProvider](#stone-code-activation) - Activate merchant's Stone Code

- [STNTableDownloaderProvider](#download-aid-and-capk-tables) - Download AID and CAPK tables from server to device

- [STNTableLoaderProvider](#loading-aid-and-capk-tables-to-the-pinpad) - Load AID and CAPK tables to pinpad

- [STNTransactionProvider](#sending-transactions) - Read customer's card and send transaction

- [STNTransactionListProvider](#transaction-listing)  - List transaction history

- [STNMerchantListProvider](#merchant-listing)  - List activated merchants in the application

- [STNCancellationProvider](#cancelling-transactions) - Cancel transaction (refund)

- [STNMailProvider](#send-receipt-via-email) - Send receipt email for transaction and cancellation

- [STNValidationProvider](#validations) - Do some validations (as if the session with pinpad is closed, tables are downloaded)

- [STNCardProvider](#fetch-pan) - Get 4 last digits in the credit card

- [STNDisplayProvider](#display-message-on-pinpad) - Display mesage on pinpad's screen

## Available models

- [STNTransactionModel](#transaction) - Transaction properties

- [STNMerchantModel](#merchant) - Merchant properties

- [STNPinpadModel](#pinpad) - Pinpad properties

- [STNAddressModel](#address) - Merchant's address properties

- [STNReceiptModel](#receipt) - Transaction receipt properties

## Other available objects

- [STNConfig](#configurations) - General configurations

- [STNPinpad]() - Pinpad object representation

## Usage

### Import SDK

Import the StoneSDK where you need to use it.

```objective-c
#import <StoneSDK/StoneSDK.h>
```

### Configurations

The class `STNConfig` provide you some useful configurations, as described below.

#### Acquirer

You can change between Stone and Elavon acquirer key, setting the value of `acquirer` property at `STNConfig`.

This can be done on the `AppDelegate`, for example:
```objective-c
- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
    // Override point for customization after application launch.

    [STNConfig setAcquirer: STNAcquirerStone];

    return YES;
}
```

#### Environment

You can change the environment in which transactions are being processed at runtime.

First, set the environment at `STNConfig` property `environment`. This should be done before stone code activation, so that it has the same environment for activation, table download and sending transactions.

For example, if you want to use the production environment:
```objective-c
[STNConfig setEnvironment: STNEnvironmentProduction];
```

You can choose between the following values:
```objective-c
STNEnvironmentProduction
STNEnvironmentInternalHomolog
STNEnvironmentSandbox
STNEnvironmentStaging
STNEnvironmentCertification
```

#### Pinpad messages

It is possible to customize the messages shown in the pinpad screen with `setTransactionMessages`.
To do so, pass in a `NSDictionary` containing the values you want with key and value as `{STNTransactionMessage: @"NSString"}`.

For example, the next value will replace the message for Transaction Declined:
`@{@(STNTransactionMessageDeclined) : @"TRANSACAO       XYZ"}`

> Remember that the display can only print 32 digits which is 16 for each line.

### Connecting to pinpads

You can connect with pinpads with Bluetooth Low Energy (BLE) and 'Classic' Bluetooth (MFi) technologies, but they are handled a bit different.

#### Old connection to a single Classic BT (MFi)

> This method is still available if you want to connect to a single non-BLE pinpad.

To communicate with the pinpad it is required to establish a session. Connect to the bluetooth device through *iOS Settings* before establishing this session.

```objective-c
    [STNPinPadConnectionProvider connectToPinpad:^(BOOL succeeded, NSError* error)
    {
        if (succeeded) // check for success
        {
          // do something
        } else
        {
            // handle error
            NSLog(@"%@", error.description);
        }
    }];
```

> We recomend this method to run this method every **3 minutes** (even if the application in in background) in case the pinpad being used is the `Gertec MOBI PIN 10`. This device has problems if no communication is made for a while.

##### Possible error code

[303](#error-codes)

#### Multiple pinpad connection

_First step: connecting to pinpad_

- For `classic Bluetooth`: first you have to connect the bluetooth on your _iOS settings_.

- For `Bluetooth Low Energy`:
   - First thing to do is to set the delegate `STNPinpadConnectionDelegate` and initialize the central manager on `STNPinpadConnectionProvider`.
   - Then you have to `startScan` for devices. In the `didFindPinpad` delegate method, you will get the devices supported by the StoneSDK, as a `STNPinpad`. Once you find the one(s) you want, you pass the `STNPinpad` as a parameter to `connectToPinpad:(STNPinpad*)pinpad`.  You should call `stopScan` at this point.

```objective-c
// Connecting to BLE pinpads

// ViewController.h

#import <UIKit/UIKit.h>
#import "StoneSDK/StoneSDK.h"

@interface ViewController : UIViewController <STNPinPadConnectionDelegate>
@end

// ViewController.m

@implementation ViewController

STNPinPadConnectionProvider* connection;

- (void)viewDidLoad
{
	[super viewDidLoad];
	connection = [[STNPinPadConnectionProvider alloc] init];

	// Sets the delegate
	connection.delegate = self;

	// Start the BLE central before trying to start scanning
	[connection startCentral];
}

- (void)startScanning
{
	// Start scanning for BLE pinpads
  [connection startScan];
}

// Delegate method
-(void)pinpadConnectionProvider:(STNPinPadConnectionProvider*)provider didStartScanning:(BOOL)success error:(NSError*)error
{
	// Checks whether the scan was successfully initialized
}

// Delegate method, called whenever a supported BLE pinpad is found
-(void)pinpadConnectionProvider:(STNPinPadConnectionProvider*)provider didFindPinpad:(STNPinpad*)pinpad
{
  // Find supported pinpads as STNPinpad

	// Check if it is the wanted pinpad
  if([pinpad.name isEqualToString: @"ID_DO_PINPAD"])
  {
    // Connect to pinpad
    [connection connectToPinpad:pinpad];
    // There's no need to keep scanning
    [connection stopScan];
  }
}

// Delegate method
-(void)pinpadConnectionProvider:(STNPinPadConnectionProvider*)provider didConnectPinpad:(STNPinpad*)pinpad error:(NSError* _ Nullable)error
{
  // Confirms pinpad connection
}

// Delegate method
-(void)pinpadConnectionProvider:(STNPinPadConnectionProvider*)provider didChangeCentralState:(CBManagerState)state
{
  // Updates whenever there's a change in the Central Manager state
  // 0 - Unknown
  // 1 - Resetting
  // 2 - Unsupported
  // 3 - Unauthorized
  // 4 - Powered off
  // 5 - Powered on
}

@end
```

_Second step: selecting wanted pinpad:_

After those first steps, for both kind of bluetooth, the devices connected will return on `listConnectedPinpads` as an array of `STNPinpad`, and they will continue to appear in this list unless you call `disconnectPinpad:(STNPinpad*)pinpad;` for BLE or disconnect the BT classic on the iOS settings (or if you close the app).
Once you find the one you want to use, you can select it passing it as a parameter to `selectPinpad:`.

```objective-c
STNPinPadConnectionProvider *connection = [[STNPinPadConnectionProvider alloc] init];
NSArray <STNPinpad*> *connectedPinpads = [connection listConnectedPinpads];
STNPinpad *wantedPinpad = connectedPinpads[0];
[connection selectPinpad:wantedPinpad];
```

_Ending a connection_

To disconnect, call `disconnectPinpad`

```objective-c
- (void)disconnectAllPinpad
{
  // Lists all connected pinpads, classic or BLE
    NSArray<STNPinpad*>* connectedPinpads = [connection listConnectedPinpads];

    for (STNPinpad* pinpad in connectedPinpads) {
      // Disconnect pinpad
        [connection disconnectPinpad:pinpad];
    }
}

-(void)pinpadConnectionProvider:(STNPinPadConnectionProvider*)provider didDisconnectPinpad:(STNPinpad*)pinpad
{
  // Confirms STNPinpad disconnection
}
```

_Other available pinpad connection information_

```objective-c

  // Indicates whether the BLE scanning is running
  BOOL isScanning = [connection isScanning];

  // Indicates the BLE Central Manager state
  STNCentralState centralState = [connection centralState];

  // Verifies if a pinpad of type STNPinpad is connected
  BOOL isConnected = [connection isPinpadConnected:pinpad];

  // Gets the currently selected pinpad
  STNPinpad* selected = [connection selectedPinpad];

  // Gets a list of pinpads with known identifiers
  NSArray<STNPinpad*> *pinpadList = [connection listPinpadsWithIdentifiers:@[@"ID1", @"ID2"]];
```

### Stone Code Activation

The provider `STNStoneCodeActivationProvider` is responsible for activating and deactivating the merchant and has the methods `activateStoneCode:withblock:`, `deactivateMerchant:` and `deactivateMerchantWithStoneCode`.

> Stone Code activation is required in order to execute any operation on the Stone SDK.

The method `activateStoneCode:withblock:` is used to activate the merchant. Pass a NSString in as parameter containing the merchant's Stone Code.

```objective-c
NSString *stoneCode = @"999999999"; // Merchant's Stone Code

[STNStoneCodeActivationProvider activateStoneCode:stoneCode withBlock:^(BOOL succeeded, NSError* error)
{
    if (succeeded) // check for success
    {
      // do something
    } else
    {
        // handle error
        NSLog(@"%@", error.description);
    }
}];
```

One option to deactivate the merchant in the application is the `deactivateMerchant:` method in which is passed the merchant (`STNMerchantModel` object) to be deactivated as parameter.

```objective-c
STNMerchantModel *merchant = [STNMerchantListProvider listMerchants][0]; // Find first merchant in the list

[STNStoneCodeActivationProvider deactivateMerchant:merchant];
```

Another option to deactivate the merchant is to use the method `deactivateMerchantWithStoneCode:`, that accepts the Stone Code as parameter.

```objective-c
NSString *stoneCode = @"999999999"; // Merchant's Stone Code

[STNStoneCodeActivationProvider deactivateMerchantWithStoneCode:stoneCode];
```

> ⚠️  Both this deactivating methods will delete the merchant from the application with all its transaction history.

#### Possible error codes

[101, 202, 209](#error-codes)

### Download AID and CAPK tables

The provider `STNTableDownloaderProvider` has the method `downloadTables` that can be used to downlod the AID and CAPK tables to the iOS device.

> The AID and CAPK tables are necessary for transactions EMV.

```objective-c
[STNTableDownloaderProvider downLoadTables:^(BOOL succeeded, NSError* error)
{
    if (succeeded) // check for success
    {
      // do something
    } else
    {
        // handle error
        NSLog(@"%@", error.description);
    }
}];
```

#### Possible error codes

[101, 201, 601](#error-codes)

### Loading AID and CAPK tables to the pinpad

The provider `STNTableLoaderProvider` has the method `loadTables` that loads the downloaded tables to the pinpad.

```objective-c
[STNTableLoaderProvider loadTables:^(BOOL succeeded, NSError* error)
{
    if (succeeded) // check for success
    {
      // do something
    } else
    {
        // handle error
        NSLog(@"%@", error.description);
    }
}];
```

#### Possible error codes

[303, 304](#error-codes)

### Sending transactions

Send transactions using the method `sendTransaction:withBlock` in the provider `STNTransactionProvider`.

The parameter `STNTransactionModel` needs to be passed in the method and needs to have the following properties defined:

#### amount (NSNumber)

Required Property. It is the value and can not contain decimal separator. For example: in case the transaction has a value of `R$ 56.45` the amount will be a `NSNumber` containing the value `5645`.

#### type (STNTransactionTypeSimplified)

Required property. Contains the transaction type (debit or credit). Use the enumeration `STNTransactionTypeSimplifiedCredit` for credit and `STNTransactionTypeSimplifiedDebit` for debit.

#### instalmentAmount (STNTransactionInstalmentAmount)

Required property. Sets the number of instalments. One of the following enumerations must be used:

- `STNTransactionInstalmentAmountOne` - 1x
- `STNTransactionInstalmentAmountTwo` - 2x
- `STNTransactionInstalmentAmountThree` - 3x
- `STNTransactionInstalmentAmountFour` - 4x
- `STNTransactionInstalmentAmountFive` - 5x
- `STNTransactionInstalmentAmountSix` - 6x
- `STNTransactionInstalmentAmountSeven` - 7x
- `STNTransactionInstalmentAmountEight` - 8x
- `STNTransactionInstalmentAmountNine` - 9x
- `STNTransactionInstalmentAmountTen` - 10x
- `STNTransactionInstalmentAmountEleven` - 11x
- `STNTransactionInstalmentAmountTwelve` - 12x

#### instalmentType (STNInstalmentType)

Required property. Self describing name. Use one of the following:

- `STNInstalmentTypeNone` - used for transactions with no instalment (`STNTransactionInstalmentAmountOne`)
- `STNInstalmentTypeMerchant` - instalment with acquirer
- `STNInstalmentTypeIssuer` - instalment with card issuer

#### initiatorTransactionKey (NSString)

**Optional** property. String containing unique value for the transaction. A default value will be generated if not set by user.

#### shortName (NSString)

**Optional** property. A custom name that will be shown in the customer's invoice. The maximum characters recommended to be correctly shown is **11**. In case it is not set the default value will be the name registered for the merchant.

#### merchant (NSMerchantModel)

**Optional** property. **This property needs to be set when there are more than 1 merchant activated**. It is the merchant that is sending the transaction. The default will always be the first activated merchant.

#### capture (STNTransactionCapture)

**Optional** property. Makes the transaction to be captured or not. Must be set with an enumeration of type `STNTransactionCapture`. The options are `STNTransactionCaptureYes` ou `STNTransactionCaptureNo`. The default is `STNTransactionCaptureYes`.

```objective-c
STNTransactionModel *transaction = [[STNTransactionModel alloc] init];

transaction.amount = [NSNumber numberWithInt:1000]; // value representing R$ 10.00
transaction.type = STNTransactionTypeSimplifiedDebit; // type debit
transaction.instalmentAmount = STNTransactionInstalmentAmountOne; // instalments: 1
transaction.instalmentType = STNInstalmentTypeNone; // instalment type: none
transaction.shortName = @"Minha Loja"; // custom name for the invoice
transaction.initiatorTransactionKey = @"9999999999999"; // custom ITK

[STNTransactionProvider sendTransaction:transaction withBlock:^(BOOL succeeded, NSError* error) {
    if (succeeded) // check for success
    {
      // do something
    } else
    {
        // handle error
        NSLog(@"%@", error.description);
    }
}];
```

#### Notification messages

During transactions the pinpad can send notification messages via `NSNotificationCenter`. These messages are displayed on pinpad's screen and can also be accessed by using a observer on NSNotificationCenter. Simply add the observer before starting the transaction and wait for a string as the example below:

```objective-c
- (void)sendTransaction
{
    // add observer that will run the method 'handleNotification:'
		// the SDK provides the define 'PINPAD_MESSAGE' containing the notification's name
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:PINPAD_MESSAGE object:nil];

    STNTransactionModel* transaction = [[STNTransactionModel alloc] init];

    transaction.amount = [NSNumber numberWithInt:1000];
    transaction.type = STNTransactionTypeSimplifiedCredit;
    transaction.instalmentAmount = STNTransactionInstalmentAmountOne;
    transaction.instalmentType = STNInstalmentTypeNone;

    [STNTransactionProvider sendTransaction:transaction withBlock:^(BOOL succeeded, NSError* error) {

        if (succeeded) // check for success
        {
          // do something
        } else
        {
            // handle error
            NSLog(@"%@", error.description);
        }
        // remove observer
        [[NSNotificationCenter defaultCenter] removeObserver:self name:PINPAD_MESSAGE object:nil];
    }];
}

- (void)handleNotification:(NSNotification*) notification
{
    // converts notification to string
    NSString* notificationString = [notification object];
    // prints it
    NSLog(@"Pinpad's message: %@", notificationString);
}
```

#### Possible error codes

[105, 201, 203, 204, 205, 206, 207, 211, 214, 303, 601](#error-codes)

### Transaction listing

The provider `STNTransactionListProvider` has the methods `listTransactions:` and `listTransactionsByPan:`.

The method `listTransactions:` returns a `NSArray` containing the past transactions (`STNTransactionModel`). The order will be from the newest one to the oldest one.

```objective-c
// Transaction array
NSArray *transactionsList = [STNTransactionListProvider listTransactions];

for (STNTransactionModel* transaction in transactionsList)
{
    NSLog(@"Transaction value: %@", transaction.amount);
    NSLog(@"Transaction status: %@", transaction.statusString);
    NSLog(@"Transaction type: %@", transaction.typeString);
}
```

The method `listTransactionsByPan:` will filter transactions by credit card (it will use the last 4 digits to filter). This method will ask for the card to be inserted on the pinpad and will return a transaction array inside the block.

```objective-c

[STNTransactionListProvider listTransactionsByPan:^(BOOL succeeded, NSArray* transactionsList, NSError* error)
{
    if (succeeded) // check for success
    {
        for (STNTransactionModel *transaction in transactionsList)
        {
            NSLog(@"Transaction value: %@", transaction.amount);
            NSLog(@"Transaction status: %@", transaction.statusString);
            NSLog(@"Transaction type: %@", transaction.typeString);
        }
    } else
    {
        // handle error
        NSLog(@"%@", error.description);
    }
}];
```

#### Possible error codes

[101, 304](#error-codes)

### Merchant listing

The provider `STNMerchantListProvider` has the method `listMerchants:` that returns a `NSArray` containing the merchants (`STNMerchantModel`) activated in the application.

```objective-c
// Merchant list
NSArray *merchantsList = [STNMerchantListProvider listMerchants];

for (STNMerchantModel* merchant in merchantsList)
{
    NSLog(@"Merchant name: %@", merchantsList.merchantName);
    NSLog(@"Merchant document number: %@", merchantsList.documentNumber);
    NSLog(@"SAK: %@", merchantsList.saleAffiliationKey);
}
```

#### Possible error codes

[101, 304](#error-codes)

### Cancelling transactions

In order to cancel a transaction (refund) you can use the method `cancelTransaction` in the provider `STNCancellationProvider` passing the transaction object (`STNTransactionModel`) as parameter.

```objective-c
// fetch the transactions
NSArray *transactionsList = [STNTransactionListProvider listTransactions];

// cast the first item in the array to STNTransactionModel
STNTransactionModel *transaction = transactionsList[0];

// cancel transaction
[STNCancellationProvider cancelTransaction:transaction withBlock:^(BOOL succeeded, NSError* error)
{
    if (succeeded) // check for success
    {
      // do something
    } else
    {
        // handle error
        NSLog(@"%@", error.description);
    }
}];
```

#### Possible error codes

[101, 210, 601](#error-codes)

### Send receipt via email

The method `sendReceiptViaEmail:` in the provider `STNMailProvider` can be used to send receipts via email.

Use the following parameters:

#### receipt (STNReceiptModel)

**Required** parameter.

This parameter represents the receipt model. It contains the following properties:
- `type`: whether it is destined to Merchant (`STNReceiptTypeMerchant`) or Customer (`STNReceiptTypeCustomer`) .
-  `transaction`: the transaction model which will provide the information to the receipt.
- `displayCompanyInformation`: a boolean value indicating if the receipt must have address information of the merchant.

#### from (STNContactModel)

**Optional** parameter. If nil, or if it's address isn't set, a Stone noreply email will be set.

A contact identifying the sender with name (optional) and email address (required).

#### destination (STNContactModel)

**Required** parameter.

A contact identifying the recipient with name (optional) and email address (required).

#### Possible error codes

[102, 103, 601](#error-codes)

### Send receipt via email (older versions)

> ⚠️ This method will be removed in the next SDK version. Use the new method to [send receipt via email](#send-receipt-via-email).

> It will only send Customer Type receipts.

The method `sendReceiptViaEmail:` in the provider `STNMailProvider` can be used to send receipts via email.

Use the following parameters:

#### mailTemplate (STNMailTemplate)

This parameter represents the email template and it can be `STNMailTemplateTransaction` for transaction receipt or `STNMailTemplateVoidTransaction` for cancellation receipt.

#### transaction (STNTransactionModel)

The transaction (`STNTransactionModel`) to be cancelled.

#### destination (NSString)

Recipient's email address.

#### displayCompanyInformation (BOOL)

Use this parameter to decide whether to show company information like address and document number or not.

> Some merchant are regular people, not companies and do not want their information exposed.

```objective-c
NSArray *transactions = [STNTransactionListProvider listTransactions];

// recipient
NSString *destination = @"john@detination.com";

// send email containing the last transaction receipt
[STNMailProvider sendReceiptViaEmail:STNMailTemplateTransaction transaction:transactions[0] toDestination:destination displayCompanyInformation:YES withBlock:^(BOOL succeeded, NSError* error)
{
    if (succeeded) // check for success
    {
      // do something
    } else
    {
        // handle error
        NSLog(@"%@", error.description);
    }
}];
```

#### Possible error codes

[102, 103, 601](#error-codes)

### Validations

The provider `STNValidationProvider` has 4 methods for validation:

#### validateActivation

Checks whether the merchant is activated or not and returns `YES` if it is activated.

#### validatePinpadConnection

Checks if pinpad has a session closed with the application and returns `YES` if it does.

#### validateTablesDownloaded

Checks whether the AID and CAPK tables were downloaded to the **iOS** device or not nd returns `YES` if they were.

#### validateConnectionToNetWork

Checks whether the internet connection is working or not and returns `YES` if it is.

```objective-c
if ([STNValidationProvider validateActivation] == YES)
{
    NSLog(@"Merchant is activated!");
}

if ([STNValidationProvider validatePinpadConnection] == YES)
{
    NSLog(@"The pinpad has a session closed with the iOS device!");
}

if ([STNValidationProvider validateTablesDownloaded] == YES)
{
    NSLog(@"The tables were already downloaded to the iOS device!");
}

if ([STNValidationProvider validateConnectionToNetWork] == YES)
{
    NSLog(@"The internet connection is ok!");
}
```

### Fetch PAN

The method `getCardPan:` in the provider `SNTCardProvider` can be used to fetch the last 4 digits of the PAN.

```objective-c
[STNCardProvider getCardPan:^(BOOL succeeded, NSString* pan, NSError* error)
{
    if (succeeded) // check for success
    {
      // do something
    } else
    {
        // handle error
        NSLog(@"%@", error.description);
    }
}];
```

#### Possible error codes

[101, 304](#error-codes)

### Display message on pinpad

The provider `STNDisplayProvider` has the method `displayMessage:withBlock:` that is used to display a message on the pinpad. The string must contain up to 16 characters.

```objective-c
[STNDisplayProvider displayMessage:@"MY MENSSAGE" withBlock:^(BOOL succeeded, NSError* error)
{
    if (succeeded) // check for success
    {
      // do something
    } else
    {
        // handle error
        NSLog(@"%@", error.description);
    }
}];
```

#### Possible error codes

[101, 105, 304](#error-codes)

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
- 303 - no session with pinpad found (**STNErrorCodePinpadConnectionNotFound**)
- 304 - no AID and CAPK tables found (**STNErrorCodeTablesNotFound**)
- 305 - error loading tables to pinpad  (**STNErrorCodeNullResponse**)
- 306 - request error (**STNErrorCodeNullResponse**)
- 401 - bluetooth not ready (**STNErrorBluetoothNotReady**)
- 601 - no internet connection (**STNErrorCodeNotConnectedToNetwork**)
