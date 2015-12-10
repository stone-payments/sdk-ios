//
//  PerformTransactionViewController.m
//  Stone Demo
//
//  Created by Erika Bueno on 11/16/15.
//  Copyright © 2015 Stone. All rights reserved.
//
//  Efetua a transação e dá a opção de envio do comprovante via e-mail.

#import "PerformTransactionViewController.h"

@interface PerformTransactionViewController ()

@property (weak, nonatomic) IBOutlet UITextField *transactionValue;
@property (weak, nonatomic) IBOutlet UISegmentedControl *transactionType;
@property (weak, nonatomic) IBOutlet UILabel *rate;
@property (weak, nonatomic) IBOutlet UISwitch *rateSwitch;
@property (nonatomic,strong) NSArray *transactionsList;
@property (nonatomic,strong) UIView *overlayView;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation PerformTransactionViewController

static int rowNumber;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    STNPinPadConnectionProvider *pinPadConnectionProvider = [[STNPinPadConnectionProvider alloc] init];
    [pinPadConnectionProvider connectToPinpad:^(BOOL succeeded, NSError *error)
     {
         if (succeeded)
         {
             NSLog(@"Pinpad conectado.");
         } else
         {
             [self showErrorMessage:[error localizedDescription]];
         }
     }];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.transactionValue.delegate = self;
    self.navigationItem.hidesBackButton = NO;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stone.png"]];
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;
    _pickerMenu = @[@"À vista", @"2 parcelas", @"3 parcelas",
                    @"4 parcelas", @"5 parcelas", @"6 parcelas",
                    @"7 parcelas", @"8 parcelas", @"9 parcelas",
                    @"10 parcelas", @"11 parcelas", @"12 parcelas"];
    self.instalmentPicker.hidden = YES;
    self.rate.hidden = YES;
    self.rateSwitch.enabled = NO;
    
    // Métodos que definem o comportamento do teclado numérico. Ver cancelNumberPad e doneWithNumberPad.
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    [numberToolbar setTintColor: [UIColor blackColor]];
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancelar" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"OK" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    self.transactionValue.inputAccessoryView = numberToolbar;
}

-(void)cancelNumberPad
{
    [self.transactionValue resignFirstResponder];
    self.transactionValue.text = @"";
}

-(void)doneWithNumberPad
{
    NSString *numberFromTheKeyboard = self.transactionValue.text;
    [self.transactionValue resignFirstResponder];
}


// Realiza a transação.

- (IBAction)performTransaction:(id)sender
{
    
    [self.overlayView addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    [self.navigationController.view addSubview:self.overlayView];
    
    // O valor da transação deve ser sempre utilizado em CENTAVOS e será utilizado como um int no objeto da transação. Ver convertToFloat.
    float realValue = [self convertToFloat:self.transactionValue.text];
    float centsFromFloatValue = 100 * realValue;
    int justCents = (int) centsFromFloatValue;
    
    // Abre a sessão com o pinpad.
    STNPinPadConnectionProvider *pinPadConnectionProvider = [[STNPinPadConnectionProvider alloc] init];
    [pinPadConnectionProvider connectToPinpad:^(BOOL succeeded, NSError *error)
     {
         if (succeeded)
         {
             NSLog(@"Pinpad conectado.");
         } else
         {
             [self showErrorMessage:[error localizedDescription]];
         }
     }];
    
    // Objeto que receberá os dados da transação.
    STNTransactionProvider *transactionProvider = [[STNTransactionProvider alloc] init];
    
    int updatedNumOfInstalments = 0;
    
    // Testa se é DÉBITO ou CRÉDITO.
    if (self.transactionType.selectedSegmentIndex == 0) { // Débito
        
        // Recebe os dados da transação (débito).
        [transactionProvider sendTransactionWithValue:(int *)justCents
                            transactionTypeSimplified:1
                                instalmentTransaction:OneInstalment
                                  orderIdentification:@"Teste transação"
                                            withBlock:^(BOOL succeeded, NSError *error)
         {
             if (succeeded)
             {
                 [self okTransaction];
                 
             } else
             {
                 [self showErrorMessage:[error localizedDescription]];
                 
             }
         }];
        
    } else { // Crédito
        
        // Testa se o campo das parcelas está vazio. Se estiver, o valor não é parcelado.
        if (rowNumber == 0)
        {
            updatedNumOfInstalments = OneInstalment;
            
        } else
        {
            if (self.rateSwitch.on)
            {
                
                // Com juros
                switch (rowNumber)
                {
                    case 1: updatedNumOfInstalments = TwoInstalmetsWithInterest;           break;  // 2 parcelas
                    case 3: updatedNumOfInstalments = ThreeInstalmetsWithInterest;         break;  // 3 parcelas
                    case 4: updatedNumOfInstalments = FourInstalmetsWithInterest;          break;
                    case 5: updatedNumOfInstalments = FiveInstalmetsWithInterest;          break;
                    case 6: updatedNumOfInstalments = SixInstalmetsWithInterest;           break;
                    case 7: updatedNumOfInstalments = SevenInstalmetsWithInterest;         break;  // ...
                    case 8: updatedNumOfInstalments = EightInstalmetsWithInterest;         break;
                    case 9: updatedNumOfInstalments = NineInstalmetsWithInterest;          break;
                    case 10: updatedNumOfInstalments = TenInstalmetsWithInterest;          break;
                    case 11: updatedNumOfInstalments = ElevenInstalmetsWithInterest;       break;
                    case 12: updatedNumOfInstalments = TwelveInstalmetsWithInterest;       break;  // 12 parcelas
                }
                
            } else
            {
                
                // sem juros
                switch (rowNumber)
                {
                    case 2: updatedNumOfInstalments = TwelveInstalmetsNoInterest;          break;  // 2 parcelas
                    case 3: updatedNumOfInstalments = ThreeInstalmetsNoInterest;           break;  // 3 parcelas
                    case 4: updatedNumOfInstalments = FourInstalmetsNoInterest;            break;
                    case 5: updatedNumOfInstalments = FiveInstalmetsNoInterest;            break;
                    case 6: updatedNumOfInstalments = SixInstalmetsNoInterest;             break;
                    case 7: updatedNumOfInstalments = SevenInstalmetsNoInterest;           break;  // ...
                    case 8: updatedNumOfInstalments = EightInstalmetsNoInterest;           break;
                    case 9: updatedNumOfInstalments = NineInstalmetsNoInterest;            break;
                    case 10: updatedNumOfInstalments = TenInstalmetsNoInterest;            break;
                    case 11: updatedNumOfInstalments = ElevenInstalmetsNoInterest;         break;
                    case 12: updatedNumOfInstalments = TwelveInstalmetsNoInterest;         break;  // 12 parcelas
                }
            }
        }
        
        
        // Recebe os dados da transação (crédito).
        [transactionProvider sendTransactionWithValue:(int *)justCents
                            transactionTypeSimplified:0
                                instalmentTransaction:updatedNumOfInstalments
                                  orderIdentification:@"Teste transação"
                                            withBlock:^(BOOL succeeded, NSError *error)
         {
             if (succeeded)
             {
                 [self okTransaction];
                 
             } else
             {
                 [self showErrorMessage:[error localizedDescription]];
             }
         }];
    }
    
    [self.overlayView removeFromSuperview];
}

- (IBAction)onORoff:(id)sender {
    if (self.rateSwitch.on)
    {
        self.rate.text = @"Com juros";
    } else
    {
        self.rate.text = @"Sem juros";
    }
}

- (IBAction)changeType:(id)sender
{
    
    switch (self.transactionType.selectedSegmentIndex)
    {
        case 0:
            NSLog(@"Débito");
            _instalmentPicker.hidden = YES;
            self.rate.hidden = YES;
            [self.rateSwitch setEnabled: NO];
            break;
            
        case 1:
            NSLog(@"Crédito");
            _instalmentPicker.hidden = NO;
            self.rate.hidden = NO;
            [self.rateSwitch setEnabled: YES];
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return  _pickerMenu.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerMenu[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    rowNumber = row;
}

// Alerta de sucesso na transação.

- (void)okTransaction
{
    UIAlertController *okTransactionAlert = [UIAlertController
                                             alertControllerWithTitle:@"Transação efetuada com sucesso!"
                                             message:@"Deseja enviar comprovante via e-mail?"
                                             preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesButton = [UIAlertAction actionWithTitle:@"Sim"
                                                        style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                {
                                    [self sendEmail];
                                    [self.overlayView addSubview:self.activityIndicator];
                                    [self.activityIndicator startAnimating];
                                    [self.navigationController.view addSubview:self.overlayView];
                                    [okTransactionAlert dismissViewControllerAnimated:YES completion: nil];
                                }];
    
    [okTransactionAlert addAction:yesButton];
    
    UIAlertAction *noButton = [UIAlertAction actionWithTitle:@"Não"
                                                       style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                               {
                                   [self performSegueWithIdentifier:@"BackToMain" sender:nil];
                                   [okTransactionAlert dismissViewControllerAnimated:YES completion: nil];
                               }];
    
    [okTransactionAlert addAction:noButton];
    [self presentViewController:okTransactionAlert animated:YES completion:nil];
    
}

// Envia e-mail com comprovante da transação que acabou de ser realizada.

- (void)sendEmail
{
    
    STNTransactionListProvider *transactionListProvider = [[STNTransactionListProvider alloc] init];
    _transactionsList = [transactionListProvider listTransactions:^(BOOL succeeded, NSError *error)
                         {
                             if (succeeded)
                             {
                                 NSLog(@"");
                             } else
                             {
                                 [self showErrorMessage:[error localizedDescription]];
                             }
                         }];
    
    // Pega a transação da posição 0 do array (última transação).
    STNTransactionInfoProvider *info = [_transactionsList objectAtIndex:0];
    
    UIAlertController *emailAlert = [UIAlertController
                                     alertControllerWithTitle:@"Envio de Comprovante"
                                     message:@"Digite o endereço de e-mail do destinatário:"
                                     preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                    {
                                        NSString *emailAddress = ((UITextField *)[emailAlert.textFields objectAtIndex:0]).text;
                                        STNMailProvider *mailProvider = [[STNMailProvider alloc] init];
                                        
                                        [mailProvider sendReceiptViaEmail:TRANSACTION transactionInfo:info
                                                            toDestination:emailAddress
                                                displayCompanyInformation:YES
                                                                withBlock:^(BOOL succeeded, NSError *error)
                                         {
                                             if (succeeded)
                                             {
                                                 [self emailSent];
                                                 
                                             } else
                                             {
                                                 [self showErrorMessage:[error localizedDescription]];
                                             }
                                         }];
                                    }];
    
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Cancelar"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                   {
                                       [self performSegueWithIdentifier:@"BackToMain" sender:nil];
                                       [emailAlert dismissViewControllerAnimated:YES completion:nil];
                                       
                                   }];
    
    [emailAlert addAction:defaultAction];
    [emailAlert addAction:cancelButton];
    [emailAlert addTextFieldWithConfigurationHandler:^(UITextField *emailField)
     {
         emailField.placeholder = @"Digite o e-mail";
     }];
    [self presentViewController:emailAlert animated:YES completion:nil];
    
}

// Alerta de e-mail enviado.

- (void)emailSent
{
    
    [self.overlayView removeFromSuperview];
    
    UIAlertController *emailSentAlert = [UIAlertController
                                         alertControllerWithTitle:@"Comprovante enviado com sucesso!"
                                         message:nil
                                         preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                               {
                                   [emailSentAlert dismissViewControllerAnimated:YES completion: nil];
                                   [self performSegueWithIdentifier:@"BackToMain" sender:nil];
                               }];
    
    [emailSentAlert addAction:okButton];
    [self presentViewController:emailSentAlert animated:YES completion:nil];
    
}

// Vai para as configurações / Settings do aparelho para ativar internet.

- (void)checkInternet
{
    
    UIAlertController *networkAlert = [UIAlertController
                                       alertControllerWithTitle:@"Sem conexão ativa com a internet!"
                                       message:@"Clique em Configurações para ativar o wi-fi ou o pacote de dados."
                                       preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *settingsButton = [UIAlertAction actionWithTitle:@"Configurações"
                                                             style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                     {
                                         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Settings"]];
                                         [networkAlert dismissViewControllerAnimated:YES completion: nil];
                                     }];
    
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Cancelar"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                   {
                                       [networkAlert dismissViewControllerAnimated:YES completion:nil];
                                   }];
    
    [networkAlert addAction:settingsButton];
    [networkAlert addAction:cancelButton];
    [self presentViewController:networkAlert animated:YES completion:nil];
}

// Alerta de erro.

-(void)showErrorMessage: (NSString *) error
{
    
    UIAlertController *errorAlert = [UIAlertController
                                     alertControllerWithTitle:@"Erro!"
                                     message:error
                                     preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action)
                               {
                                   [errorAlert dismissViewControllerAnimated:YES completion:nil];
                               }];
    
    [errorAlert addAction:okButton];
    [self presentViewController:errorAlert animated:YES completion:nil];
}

// Formata o campo de inserção do valor da transação.

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    NSInteger MAX_DIGITS = 13; // 999,999.99
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setMinimumFractionDigits:2];
    
    NSString *stringMaybeChanged = [NSString stringWithString:string];
    if (stringMaybeChanged.length > 1)
    {
        NSMutableString *stringPasted = [NSMutableString stringWithString:stringMaybeChanged];
        
        [stringPasted replaceOccurrencesOfString:numberFormatter.currencySymbol
                                      withString:@""
                                         options:NSLiteralSearch
                                           range:NSMakeRange(0, [stringPasted length])];
        
        [stringPasted replaceOccurrencesOfString:numberFormatter.groupingSeparator
                                      withString:@""
                                         options:NSLiteralSearch
                                           range:NSMakeRange(0, [stringPasted length])];
        
        NSDecimalNumber *numberPasted = [NSDecimalNumber decimalNumberWithString:stringPasted];
        stringMaybeChanged = [numberFormatter stringFromNumber:numberPasted];
    }
    
    UITextRange *selectedRange = [textField selectedTextRange];
    UITextPosition *start = textField.beginningOfDocument;
    NSInteger cursorOffset = [textField offsetFromPosition:start toPosition:selectedRange.start];
    NSMutableString *textFieldTextStr = [NSMutableString stringWithString:textField.text];
    NSUInteger textFieldTextStrLength = textFieldTextStr.length;
    
    [textFieldTextStr replaceCharactersInRange:range withString:stringMaybeChanged];
    
    [textFieldTextStr replaceOccurrencesOfString:numberFormatter.currencySymbol
                                      withString:@""
                                         options:NSLiteralSearch
                                           range:NSMakeRange(0, [textFieldTextStr length])];
    
    [textFieldTextStr replaceOccurrencesOfString:numberFormatter.groupingSeparator
                                      withString:@""
                                         options:NSLiteralSearch
                                           range:NSMakeRange(0, [textFieldTextStr length])];
    
    [textFieldTextStr replaceOccurrencesOfString:numberFormatter.decimalSeparator
                                      withString:@""
                                         options:NSLiteralSearch
                                           range:NSMakeRange(0, [textFieldTextStr length])];
    
    if (textFieldTextStr.length <= MAX_DIGITS)
    {
        NSDecimalNumber *textFieldTextNum = [NSDecimalNumber decimalNumberWithString:textFieldTextStr];
        NSDecimalNumber *divideByNum = [[[NSDecimalNumber alloc] initWithInt:10] decimalNumberByRaisingToPower:numberFormatter.maximumFractionDigits];
        NSDecimalNumber *textFieldTextNewNum = [textFieldTextNum decimalNumberByDividingBy:divideByNum];
        NSString *textFieldTextNewStr = [numberFormatter stringFromNumber:textFieldTextNewNum];
        
        textField.text = textFieldTextNewStr;
        
        if (cursorOffset != textFieldTextStrLength)
        {
            NSInteger lengthDelta = textFieldTextNewStr.length - textFieldTextStrLength;
            NSInteger newCursorOffset = MAX(0, MIN(textFieldTextNewStr.length, cursorOffset + lengthDelta));
            UITextPosition* newPosition = [textField positionFromPosition:textField.beginningOfDocument offset:newCursorOffset];
            UITextRange* newRange = [textField textRangeFromPosition:newPosition toPosition:newPosition];
            [textField setSelectedTextRange:newRange];
        }
    }
    
    return NO;
}

// Converte o número para float, trata a questão da vírgula e/ou do ponto como separador para decimal.

- (float)convertToFloat:(NSString*)fromFormatedString
{
    NSMutableString *textFieldStrValue = [NSMutableString stringWithString:fromFormatedString];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setMinimumFractionDigits:2];
    
    [textFieldStrValue replaceOccurrencesOfString:numberFormatter.groupingSeparator
                                       withString:@""
                                          options:NSLiteralSearch
                                            range:NSMakeRange(0, [textFieldStrValue length])];
    
    // Muda o separador decimal para ponto caso esteja numa localidade que use vírgula.
    [textFieldStrValue replaceOccurrencesOfString:numberFormatter.decimalSeparator
                                       withString:@"."
                                          options:NSLiteralSearch
                                            range:NSMakeRange(0, [textFieldStrValue length])];
    
    float textFieldNum = [[NSDecimalNumber decimalNumberWithString:textFieldStrValue] floatValue];
    
    return textFieldNum;
}

@end