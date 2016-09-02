//
//  AddressBookTool.m
//  写入通讯录
//
//  Created by kangbing on 16/9/2.
//  Copyright © 2016年 kangbing. All rights reserved.
//

#import "AddressBookTool.h"
#import <AddressBook/AddressBook.h>
#import <ContactsUI/ContactsUI.h>

#define IOS7   ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] == NSOrderedAscending )
#define IOS9   ( [[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending )
#define IOS8   ((!IOS7) && (!IOS9))

@implementation AddressBookTool


+ (void)insertAnContentName:(NSString *)name andWithPhoneNum:(NSString *)phoneNum{
    
    if((name.length < 1)||(phoneNum.length < 1)){
        NSLog(@"输入属性不能为空");
        return;
    }

    if (IOS8) {
        
        CFErrorRef error = NULL;
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
        ABRecordRef newRecord = ABPersonCreate();
        ABRecordSetValue(newRecord, kABPersonFirstNameProperty, (__bridge CFTypeRef)name, &error);
        
        ABMutableMultiValueRef multi = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(multi, (__bridge CFTypeRef)phoneNum, kABPersonPhoneMobileLabel, NULL);
        ABRecordSetValue(newRecord, kABPersonPhoneProperty, multi, &error);
        CFRelease(multi);
        
        ABAddressBookAddRecord(addressBook, newRecord, &error);
        
        ABAddressBookSave(addressBook, &error);
        CFRelease(newRecord);
        CFRelease(addressBook);
        
        NSLog(@"ios8");
        
    }else if (IOS9){
    
        NSLog(@"ios9");
        CNMutableContact * contact = [[CNMutableContact alloc]init];
        contact.givenName = name?:@"defaultname";
        CNLabeledValue *phoneNumber = [CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberMobile value:[CNPhoneNumber phoneNumberWithStringValue:phoneNum ?:@"10086"]];
        contact.phoneNumbers = @[phoneNumber];
        
        // 把对象加到请求中
        CNSaveRequest * saveRequest = [[CNSaveRequest alloc]init];
        [saveRequest addContact:contact toContainerWithIdentifier:nil];
        
        // 执行请求
        CNContactStore * store = [[CNContactStore alloc]init];
        [store executeSaveRequest:saveRequest error:nil];
    
    
    }else{
        
        NSLog(@"ios7");
       
        CFErrorRef error = NULL;
        
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
        ABRecordRef newRecord = ABPersonCreate();
        ABRecordSetValue(newRecord, kABPersonFirstNameProperty, (__bridge CFTypeRef)name, &error);
        
        ABMutableMultiValueRef multi = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(multi, (__bridge CFTypeRef)name, kABPersonPhoneMobileLabel, NULL);
        
        ABRecordSetValue(newRecord, kABPersonPhoneProperty, multi, &error);
        CFRelease(multi);
        
        ABAddressBookAddRecord(addressBook, newRecord, &error);
        
        ABAddressBookSave(addressBook, &error);
        CFRelease(newRecord);
        CFRelease(addressBook);
        
    
    
    }
    
    
    
    




}

@end
