//
//  PerformTransaction.m
//  Demo Objc
//
//  Created by Eduardo Mello de Macedo | Stone on 24/02/17.
//  Copyright © 2017 Eduardo Mello de Macedo | Stone. All rights reserved.
//

#import "PerformTransactionViewController.h"
#import "NSString+Utils.h"
#import "DemoPreferences.h"

@interface PerformTransactionViewController ()

@property (strong, nonatomic) NSArray *pickerMenu;
@property (weak, nonatomic) NSString *instalmentString;

@property (strong, nonatomic) IBOutlet UILabel *instructionLabel;
@property (strong, nonatomic) IBOutlet UILabel *interestLabel;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;

@property (weak, nonatomic) IBOutlet UILabel *feedback;
@property (weak, nonatomic) IBOutlet UITextField *transactionValue;
@property (weak, nonatomic) IBOutlet UISegmentedControl *transactionType;
@property (weak, nonatomic) IBOutlet UIPickerView *instalmentPicker;
@property (weak, nonatomic) IBOutlet UILabel *rate;
@property (weak, nonatomic) IBOutlet UISwitch *rateSwitch;

@end

@implementation PerformTransactionViewController

static int rowNumber;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.transactionValue.delegate = self;
    self.navigationItem.hidesBackButton = NO;
    
    self.navigationItem.title = [kTitleSendTransaction localize];
    self.instructionLabel.text = [kInstructionAmount localize];
    self.interestLabel.text = [kGeneralInterestFree localize];
    [self.sendButton setTitle:[kButtonSend localize] forState:UIControlStateNormal];
    [self.transactionType setTitle:[kGeneralDebit localize] forSegmentAtIndex:0];
    [self.transactionType setTitle:[kGeneralCredit localize] forSegmentAtIndex:1];
    
    self.pickerMenu = @[@"1x", @"2x", @"3x", @"4x", @"5x", @"6x", @"7x", @"8x", @"9x", @"10x", @"11x", @"12x"];
    
    self.instalmentPicker.hidden = YES;
    self.rate.hidden = YES;
    self.rateSwitch.enabled = NO;
    self.rateSwitch.on = NO;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
    
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.center = self.overlayView.center;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)performTransaction:(id)sender {
    
    [self.overlayView addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    [self.navigationController.view addSubview:self.overlayView];
    
    /*
        O valor da transação deve ser sempre por CENTAVOS e para isso 
        devemos utilizar com um int no objeto da transação;
     */
    NSString *transactionValue = [[self.transactionValue.text stringByReplacingOccurrencesOfString:@"," withString:@""] stringByReplacingOccurrencesOfString:@"." withString:@""];
    int justCents = [transactionValue intValue];
    
    // Iniciando o modelo transaction para efetivar a transacao;
    STNTransactionModel *transaction = [[STNTransactionModel alloc] init];
    
    // Propriedade Obrigatória, deve conter o valor da transação em centavos. (EX. R$ 56,45 = 5645);
    transaction.amount = [NSNumber numberWithInteger:justCents];
    
    
    // Verifica se é DÉBITO ou CRÉDITO.
    if (self.transactionType.selectedSegmentIndex == 0) { // é Débito
        
        // Propriedade Obrigatória, define o número de parcelas da transação;
        transaction.instalmentAmount = STNTransactionInstalmentAmountOne;
        
        // Propriedade Obrigatória, define o tipo de transação, se é débito ou crédito;
        transaction.type = STNTransactionTypeSimplifiedDebit;
        
        // Propriedade Obrigatória, define o tipo de parcelamento, com juros, sem juros ou pagamento a vista;
        transaction.instalmentType = STNInstalmentTypeNone;
        
    } else { // é Crédito
        
        // Propriedade Obrigatória, define o tipo de transação, se é débito ou crédito;
        transaction.type = STNTransactionTypeSimplifiedCredit;
        
        transaction.instalmentType = STNInstalmentTypeNone;
        if (_rateSwitch.isEnabled && rowNumber > 0){
            if (_rateSwitch.isOn) {
                // Propriedade Obrigatória, define o tipo de parcelamento, com juros, sem juros ou pagamento a vista;
                transaction.instalmentType = STNInstalmentTypeIssuer;
            }
            else {
                // Propriedade Obrigatória, define o tipo de parcelamento, com juros, sem juros ou pagamento a vista;
                transaction.instalmentType = STNInstalmentTypeMerchant;
            }
        }

        // Propriedade Obrigatória, define o número de parcelas da transação;
        switch (rowNumber) {
            case 0: transaction.instalmentAmount = STNTransactionInstalmentAmountOne;
                transaction.instalmentType = STNInstalmentTypeNone;
                break; // 1 parcela ou à vista;
            case 1: transaction.instalmentAmount = STNTransactionInstalmentAmountTwo; break; // 2 parcelas
            case 2: transaction.instalmentAmount = STNTransactionInstalmentAmountThree; break; // ...
            case 3: transaction.instalmentAmount = STNTransactionInstalmentAmountFour; break;
            case 4: transaction.instalmentAmount = STNTransactionInstalmentAmountFive; break;
            case 5: transaction.instalmentAmount = STNTransactionInstalmentAmountSix; break;
            case 6: transaction.instalmentAmount = STNTransactionInstalmentAmountSeven; break;
            case 7: transaction.instalmentAmount = STNTransactionInstalmentAmountEight; break;
            case 8: transaction.instalmentAmount = STNTransactionInstalmentAmountNine; break;
            case 9: transaction.instalmentAmount = STNTransactionInstalmentAmountTen; break;
            case 10: transaction.instalmentAmount = STNTransactionInstalmentAmountEleven; break; // ...
            case 11: transaction.instalmentAmount = STNTransactionInstalmentAmountTwelve; break;  // 12 parcelas
        }
        
        NSLog(@"transaction.instalmentAmount: %d", (int)transaction.instalmentAmount);
    }
//    transaction.capture = STNTransactionCaptureNo;
//    transaction.capture = STNTransactionCaptureYes;
    // Vamos efetivar a transacao;
    
    NSArray *merchants;
    merchants = [STNMerchantListProvider listMerchants];
    if ([merchants count]>0) {
        STNMerchantModel *merchant = [merchants objectAtIndex:0];
        transaction.merchant = merchant;
    }
    
//    [STNConfig setEnvironment:STNEnvironmentInternalHomolog];

    [STNTransactionProvider sendTransaction:transaction withBlock:^(BOOL succeeded, NSError *error) {
        [self.overlayView removeFromSuperview];
        if (succeeded) {
            NSLog(@"%@", [kLogTransactionSuccess localize]);
            self.feedback.text = [kLogTransactionSuccess localize];
        } else {
            self.feedback.text = error.description;
            NSLog(@"%@. [%@]", [kGeneralErrorMessage localize], error);
        }
     }];
}


- (IBAction)onOrOff:(id)sender {
    if (self.rateSwitch.on) {
        NSLog(@"%@", [kGeneralWithInterest localize]);
        self.rate.text = [kGeneralWithInterest localize];
    } else {
        NSLog(@"%@",  [kGeneralInterestFree localize]);
        self.rate.text = [kGeneralInterestFree localize];
    }
}

- (IBAction)changeType:(id)sender {
    switch (self.transactionType.selectedSegmentIndex) {
        case 0:
            NSLog(@"%@", [kGeneralDebit localize]);
            _instalmentPicker.hidden = YES;
            self.rate.hidden = YES;
            [self.rateSwitch setEnabled:NO];
            break;
        case 1:
            NSLog(@"%@", [kGeneralCredit localize]);
            _instalmentPicker.hidden = NO;
            self.rate.hidden = NO;
            [self.rateSwitch setEnabled:YES];
            break;
    }
}

// Converte o número para float, trata a questão da vírgula e/ou do ponto como separador para decimal.

- (float)convertToFloat:(NSString*)fromFormatedString {
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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickerMenu.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.pickerMenu[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    rowNumber = row;
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string {
    NSInteger MAX_DIGITS = 13; // 999,999.99
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setMinimumFractionDigits:2];
    
    NSString *stringMaybeChanged = [NSString stringWithString:string];
    if (stringMaybeChanged.length > 1) {
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
    
    if (textFieldTextStr.length <= MAX_DIGITS) {
        NSDecimalNumber *textFieldTextNum = [NSDecimalNumber decimalNumberWithString:textFieldTextStr];
        NSDecimalNumber *divideByNum = [[[NSDecimalNumber alloc] initWithInt:10] decimalNumberByRaisingToPower:numberFormatter.maximumFractionDigits];
        NSDecimalNumber *textFieldTextNewNum = [textFieldTextNum decimalNumberByDividingBy:divideByNum];
        NSString *textFieldTextNewStr = [numberFormatter stringFromNumber:textFieldTextNewNum];
        
        textField.text = textFieldTextNewStr;
        
        if (cursorOffset != textFieldTextStrLength) {
            NSInteger lengthDelta = textFieldTextNewStr.length - textFieldTextStrLength;
            NSInteger newCursorOffset = MAX(0, MIN(textFieldTextNewStr.length, cursorOffset + lengthDelta));
            UITextPosition* newPosition = [textField positionFromPosition:textField.beginningOfDocument offset:newCursorOffset];
            UITextRange* newRange = [textField textRangeFromPosition:newPosition toPosition:newPosition];
            [textField setSelectedTextRange:newRange];
        }
    }
    
    return NO;
}

@end
